import 'package:flutter/material.dart';
import 'package:notesapp/model/notes_database.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // on app start up
    super.initState();
    readNotes();
  }

  @override
  Widget build(BuildContext context) {
    //database note
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: createNote,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context,index){
          // get each note
          final note = currentNotes[index];
          //list UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //edit button
                  IconButton(
                      onPressed: () => updateNote(note),
                      icon: const Icon(Icons.edit)),
                  //delete button
                  IconButton(
                      onPressed: () => deleteNode(note.id),
                      icon: const Icon(Icons.edit))
                ],
            ),
          );
      }
      ),
    );
  }

  // create a note
  void createNote(){
    showDialog(context: context, builder: (context) =>
         AlertDialog(
          content: TextField(
            controller: textController,
            maxLines: 5,
          ),
           actions: [
             //create button
             MaterialButton(onPressed: (){
               context.read<NoteDatabase>().addNote(textController.text);
               //clear controller
               textController.clear();
               Navigator.pop(context);
             },
            child: const Text(
              'Create',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          )
           ],
    ),
    );

  }
  // read notes
  void readNotes(){
    context.read<NoteDatabase>().getAllNotes();
  }

  // update note

  void updateNote(Note note) {
    //pre-fill text
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Update Note'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                //update button
                MaterialButton(
                  onPressed: () {
                    //update note on db
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    //clear controller
                    textController.clear();
                    //pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ));
  }

  // delete note
  void deleteNode(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }
}
