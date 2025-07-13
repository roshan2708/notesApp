import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:notes_app/screens/HomeScreen.dart';
import 'package:notes_app/services/NoteService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  final noteService = NoteService();
  await noteService.init();

  runApp(MyApp(noteService: noteService));
}

class MyApp extends StatelessWidget {
  final NoteService noteService;

  const MyApp({super.key, required this.noteService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
       
      ),
      home: HomeScreen(noteService: noteService),
    );
  }
}
