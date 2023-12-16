import 'dart:math';

import 'package:flutter/material.dart';
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
  List<Color> titleColor = [
    const Color(0xffFBE4D8),
    const Color(0xffDFB6B2),
    const Color(0xff845F6C),
  ];

  getRandomColor() {
    Random random = Random();
    return titleColor[random.nextInt(titleColor.length)];
  }

  // addData(String title, String desc,) async {
  //   await context.read<NotesProvider>().addNotes(NotesModel(title: title, desc: desc));
  // }
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
    final provider=context.watch<NotesProvider>();
    final reader=context.read<NotesProvider>();
    return Consumer<NotesProvider>(
        builder: (_,notesProvider,__){
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
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateScreen()));
                     },
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Text(
                          "${context.watch<NotesProvider>().listNotes[index].id}",
                            style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                            context.watch<NotesProvider>().listNotes[index].title.toString()),
                        subtitle:
                        Text(context.watch<NotesProvider>().listNotes[index].desc.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            var id = reader.listNotes[index].id;
                            reader.deleteNotes(id!);
                            reader.getAllData();
                          },
                          icon: Icon(Icons.delete),
                        )
                      // Icon(Icons.delete),
                    ),
                  ),
                );
              },
              itemCount: context.watch<NotesProvider>().listNotes.length,
            )
          // ListView.builder(
          //     itemCount: data.length,
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {
          //           titleController.text = data[index].title;
          //           descController.text = data[index].desc;
          //           showModalBottomSheet(
          //               context: context,
          //               builder: (BuildContext context) {
          //                 return Container(
          //                   height: 400,
          //                   width: 400,
          //                   padding: EdgeInsets.symmetric(horizontal: 16),
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(25),
          //                   ),
          //                   child: Center(
          //                     child: SingleChildScrollView(
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           CustomTextField(
          //                               hint: "title",
          //                               controller: titleController),
          //                           CustomTextField(
          //                               hint: "desc", controller: descController),
          //                           const SizedBox(
          //                             height: 20,
          //                           ),
          //                           ElevatedButton(
          //                               onPressed: () {
          //                                 var utitle =
          //                                     titleController.text.toString();
          //                                 var udesc =
          //                                     descController.text.toString();
          //                                 db.updateNotes(NotesModel(
          //                                     title: utitle,
          //                                     desc: udesc,
          //                                     id: data[index].id));
          //                                 getAppData();
          //                                 Navigator.pop(context);
          //                               },
          //                               child: Text("Update"))
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               });
          //         },
          //         child: Card(
          //           color: getRandomColor(),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8)),
          //           elevation: 5,
          //           child: ListTile(
          //             contentPadding: const EdgeInsets.all(12),
          //             leading: Text(
          //               "${data[index].id}",
          //               style: const TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             title: Text(
          //               data[index].title.toString(),
          //               style: const TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             subtitle: Text(
          //               data[index].desc.toString(),
          //               style: const TextStyle(color: Colors.black),
          //             ),
          //             trailing: IconButton(
          //                 onPressed: () {
          //                   db.deleteNotes(data[index].id!);
          //                   getAppData();
          //                 },
          //                 icon: const Icon(Icons.delete)),
          //           ),
          //         ),
          //       );
          //     }),
        ),
      );
    });
  }

// _showBottomsheet() {
//   return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext buildContext) {
//         return Container(
//           alignment: Alignment.center,
//           height: 400.0,
//           width: 400.0,
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(36), topRight: Radius.circular(36)),
//           ),
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CustomTextField(
//                       hint: " Enter a name", controller: titleController),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextField(
//                       hint: " Enter desc", controller: descController),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           maximumSize: const Size(300, 50),
//                           minimumSize: const Size(300, 50),
//                           backgroundColor: Colors.deepPurple,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           )),
//                       onPressed: () async {
//                         // await db.insertData(NotesModel(
//                         //     title: titleController.text.toString(),
//                         //     desc: descController.text.toString()));
//                         // await getAppData();
//                         await addData(
//                             titleController.text, descController.text);
//                         Navigator.pop(context);
//                         //  Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotesAddScreen()));
//                       },
//                       child: const Text("Save"))
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }
}
