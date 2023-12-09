import 'package:flutter/material.dart';
import 'package:notes_app/custom_widget/circle_button.dart';
import 'package:notes_app/custom_widget/radiotile.dart';
import 'package:notes_app/custom_widget/textfield.dart';
import 'package:notes_app/data/db_helper.dart';
import 'package:notes_app/models/notes_model.dart';

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

  @override
  void initState() {
    super.initState();
    db = DbHelper.instance;
    getAppData();
  }

  getAppData() async {
    data = await db.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 2,
          title: Text("Notes app"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomsheet();
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  titleController.text=data[index].title;
                  descController.text=data[index].desc;
                   showModalBottomSheet(context: context, builder: (BuildContext context){
                      return Container(
                        height: 400,
                        width: 400,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),

                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextField(hint: "title", controller: titleController),
                                CustomTextField(hint: "desc", controller: descController),
                                const SizedBox(height: 20,),
                                ElevatedButton(onPressed: (){
                                  var utitle=titleController.text.toString();
                                  var udesc=descController.text.toString();
                                  db.updateNotes(NotesModel(title: utitle, desc: udesc, id: data[index].id));
                                   getAppData();
                                    Navigator.pop(context);
                                }, child: Text("Update"))
                              ],
                            ),
                          ),
                        ),
                      );
                   });
                },
                child: ListTile(

                  leading: Text("${data[index].id}",
                    style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  title: Text(data[index].title.toString(),
                    style: const TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data[index].desc.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: IconButton(onPressed: (){
                     db.deleteNotes(data[index].id!);
                      getAppData();
                  }, icon:  const Icon(Icons.delete)),
                ),
              );
            }),
      ),
    );
  }

  _showBottomsheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: 400.0,
            width: 400.0,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36), topRight: Radius.circular(36)),
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                        hint: " Enter a name", controller: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        hint: " Enter desc", controller: descController),
                    const SizedBox(
                      height: 10,
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
                        onPressed: () async {
                         await db.insertData(NotesModel(
                              title: titleController.text.toString(),
                              desc: descController.text.toString()));
                          await getAppData();
                          Navigator.pop(context);
                        },
                        child: const Text("Save"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
