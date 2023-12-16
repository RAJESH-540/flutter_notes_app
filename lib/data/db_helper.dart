import 'dart:io';
import 'package:notes_app/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();
  Database? _database;
  static const note_table = "note";
  static const note_id = "note_id";
  static const note_title = "note_title";
  static const note_desc = "note_desc";

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notesdb.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute(
          "create table $note_table ($note_id integer primary key autoincrement,$note_title text,$note_desc text)");
    });
  }

  Future<int> insertData(NotesModel notesModel) async {
    var db = await getDb();
    var result = db.insert(note_table, notesModel.toMap());
    return result;
  }

  Future<List<NotesModel>> getData() async {
    var db = await getDb();
    List<NotesModel> listNotes = [];
    var data = await db.query(note_table);
    for (Map<String, dynamic> eachData in data) {
      NotesModel notesModel = NotesModel.fromMap(eachData);
      listNotes.add(notesModel);
    }
    return listNotes;
  }

  Future<int> updateNotes(NotesModel notesModel) async {
    var db = await getDb();
    var result = db.update(note_table, notesModel.toMap(),
        where: "$note_id= ${notesModel.id}");
    return result;
  }

  Future<bool> deleteNotes(int id) async {
    var db = await getDb();
    var count = await db
        .delete(note_table, where: "$note_id=?", whereArgs: [id.toString()]);
    return count > 0;
  }

}
