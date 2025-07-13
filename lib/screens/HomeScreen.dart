import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:notes_app/services/NoteService.dart';
import 'package:notes_app/widgets/NoteCard.dart';
import 'AddNoteScreen.dart';

class HomeScreen extends StatelessWidget {
  final NoteService noteService;

  const HomeScreen({super.key, required this.noteService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: ValueListenableBuilder(
        valueListenable: noteService.notesListenable,
        builder: (context, Box<Note> box, _) {
          final notes = box.values.toList();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(note: notes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteScreen(noteService: noteService),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
