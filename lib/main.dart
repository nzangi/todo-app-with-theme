import 'package:flutter/material.dart';
import 'package:notesapp/model/notes_database.dart';
import 'package:notesapp/pages/notes_page.dart';
import 'package:notesapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize the ISAR DataBase
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    MultiProvider(providers: [
      //note provider
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    )

    // ChangeNotifierProvider(create: (context) => NoteDatabase(),
    //   child: const MyApp(),
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: HomePage(),
    );
  }
}

