import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/components/drawer.dart';
import 'package:notesapp/components/note_tile.dart';
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
    // Get all the data on app start up
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: createNote,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context,index){
                // get each note
                final note = currentNotes[index];
                //list UI
                  return NoteTile(
                    text: note.text,
                    onEditPressed: () => updateNote(note),
                    onDeletePressed: () => deleteNote(note.id),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  // create a note
  void createNote(){
    showDialog(context: context, builder: (context) =>
         AlertDialog(
           backgroundColor: Theme.of(context).colorScheme.background,
           content: TextField(
            controller: textController,
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
          backgroundColor: Theme.of(context).colorScheme.background,
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
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }
}
