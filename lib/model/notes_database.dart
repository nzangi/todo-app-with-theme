import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notesapp/model/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  //INITIALIZE DATABASE
  static Future<void> initialize() async{
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [NoteSchema],
        directory: directory.path
    );
  }

  // list nodes
  final List<Note> currentNotes = [];

  //CREATE a note and add it to DB
  Future<void> addNote(String note) async{
    //create a note
    final newNote = Note()..text = note;
    //save to DB
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from DB
    getAllNotes();

  }

  //READ notes from DB
  Future<void> getAllNotes() async {
    // get all notes
    List<Note> getAllNotes = await isar.notes.where().findAll();
    // clear current noted on list
    currentNotes.clear();
    //get all the list on DB NOW
    currentNotes.addAll(getAllNotes);
    notifyListeners();

  }

  //UPDATE a note from DB
  Future<void> updateNote(int id,String newText) async {
    //check the current id
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      // set the value of new text
      existingNote.text= newText;
      // update the note
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // fetch all the notes from db
      await getAllNotes();
    }
  }

  //DELETE from DB
  Future<void> deleteNote(int id) async {
    //delete the note
    await isar.writeTxn(() => isar.notes.delete(id));
    // get all notes
    await getAllNotes();
  }

}