import 'package:flutter/material.dart';
import 'package:notesapp/model/notes_database.dart';
import 'package:notesapp/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize the ISAR DataBase
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    ChangeNotifierProvider(create: (context) => NoteDatabase(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

