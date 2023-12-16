import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/provider/provider.dart';
import 'package:provider/provider.dart';

import '../custom_widget/textfield.dart';
import 'home_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(

        builder: (_,provider,__){
          return

            Scaffold(
            appBar: AppBar(
              title: Text("Update Notes"),
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
                         var utitle= titleController.text.toString();
                         var uDesc= descController.text.toString();
                         // context.read<NotesProvider>().update(NotesModel(title: utitle, desc: uDesc, id: ));
                         context.read<NotesProvider>().getAllData();
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const NotesHomeScreen()));
                      },
                      child: const Text("Update"))
                ],
              ),
            ),
          );
        });

  }
}
