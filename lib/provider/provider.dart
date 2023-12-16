import 'package:flutter/cupertino.dart';
import 'package:notes_app/data/db_helper.dart';
import 'package:notes_app/models/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  DbHelper dbHelper = DbHelper.instance;
  List<NotesModel> listNotes = [];

   void addNotes(NotesModel notesModel) async {
    var check = await dbHelper.insertData(notesModel);
    if (check==true) {
      listNotes = await dbHelper.getData();
        notifyListeners();

    }
  }

  void fetchInitialData() async {
    listNotes = await dbHelper.getData();
    notifyListeners();
  }

  Future<List<NotesModel>> getAllData() async {
    fetchInitialData();
    return listNotes;
  }

  void update(NotesModel notesId) async {
    var data = await dbHelper.updateNotes(notesId);
    if (data == 1) {
      listNotes = await dbHelper.getData();
      notifyListeners();
    }
  }

  void deleteNotes(int id) async {
    var data = await dbHelper.deleteNotes(id);
    if (data) {
      listNotes = await dbHelper.getData();
      notifyListeners();
    }
  }
}
