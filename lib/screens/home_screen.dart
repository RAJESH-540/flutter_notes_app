import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/custom_widget/snakbar.dart';
import 'package:notes_app/data/db_helper.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/provider/provider.dart';
import 'package:notes_app/screens/data_add_screen.dart';
import 'package:notes_app/screens/update_screen.dart';
import 'package:provider/provider.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  late DbHelper db;
  List<NotesModel> data = [];
  List<NotesProvider> list = [];
  List<Color> titleColor = [
    const Color(0xffFBE4D8),
    const Color(0xffDFB6B2),
    const Color(0xff845F6C),
  ];

  getRandomColor() {
    Random random = Random();
    return titleColor[random.nextInt(titleColor.length)];
  }

  deleteNotes(int id) async {
    context.read<NotesProvider>().deleteNotes(id);
    await context.read<NotesProvider>().getAllData();
  }

  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final reader = context.read<NotesProvider>();
    return Consumer<NotesProvider>(builder: (_, notesProvider, __) {
      return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            // backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 2,
              title: const Text("Notes app"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotesAddScreen()));
              },
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  color: getRandomColor(),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  UpdateScreen(index: index,)));
                    },
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Text(
                          "${context.read<NotesProvider>().listNotes[index].id}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        title: Text(context
                            .read<NotesProvider>()
                            .listNotes[index]
                            .title
                            .toString()),
                        subtitle: Text(context
                            .read<NotesProvider>()
                            .listNotes[index]
                            .desc
                            .toString()),
                        trailing: IconButton(
                          onPressed: () {
                            var id = reader.listNotes[index].id;
                            reader.deleteNotes(id!);
                            reader.getAllData();
                            var _snackbar = SnackBar(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                                content: const Text(
                                  "You delete this item Successfully ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackbar);
                          },
                          icon: const Icon(Icons.delete),
                        )),
                  ),
                );
              },
              itemCount: context.watch<NotesProvider>().listNotes.length,
            )
            ),
      );
    });
  }

}
