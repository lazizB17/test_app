import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  static const id = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String data = "No Data";

  @override
  initState() {
    super.initState();
    readData();
  }

  Future<File> writeText() async {
    final directory = await getApplicationDocumentsDirectory();
    print("path: ${directory.path}");
    final file = File('${directory.path}/note.txt');

    // Write the file
    return file.writeAsString(controller.text);
  }

  Future<void> readData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/note.txt');

      // Read the file
      final contents = await file.readAsString();

      setState(() {
        data =  contents;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text("Read Data: $data", style: TextStyle(fontSize: 20),)),
            const SizedBox(height: 20,),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Write Data',
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
              onEditingComplete: () async {
                await writeText();
                await readData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
