import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/provider/provider.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../custom_widget/textfield.dart';

class NotesAddScreen extends StatefulWidget {
  const NotesAddScreen({super.key});

  @override
  State<NotesAddScreen> createState() => _NotesAddScreenState();
}

class _NotesAddScreenState extends State<NotesAddScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  void addNotes(String title, String desc) async {
    context
        .read<NotesProvider>()
        .addNotes(NotesModel(title: title, desc: desc));
    // context.read<NotesProvider>().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(hint: " Enter a name", controller: titleController),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(hint: " Enter desc", controller: descController),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    maximumSize: const Size(300, 50),
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  addNotes(titleController.text.toString(),
                      descController.text.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotesHomeScreen()));
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
