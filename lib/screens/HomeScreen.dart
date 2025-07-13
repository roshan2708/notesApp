import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants/Colors.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:notes_app/services/NoteService.dart';
import 'package:notes_app/widgets/NoteCard.dart';
import 'AddNoteScreen.dart';
import 'EditNoteScreen.dart';

class HomeScreen extends StatelessWidget {
  final NoteService noteService;

  const HomeScreen({super.key, required this.noteService});

  void _deleteNote(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: VintageColors.cardBackground,
          title: const Text(
            'Delete Note',
            style: TextStyle(color: VintageColors.primaryText),
          ),
          content: const Text(
            'Are you sure you want to delete this note?',
            style: TextStyle(color: VintageColors.secondaryText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: VintageColors.buttonSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                noteService.deleteNote(noteId);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: VintageColors.buttonDelete),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditNoteScreen(noteService: noteService, note: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VintageColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(
            color: VintageColors.creamWhite,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: VintageColors.primaryBrown,
        elevation: 4,
        shadowColor: VintageColors.shadowColor,
      ),
      body: ValueListenableBuilder(
        valueListenable: noteService.notesListenable,
        builder: (context, Box<Note> box, _) {
          final notes = box.values.toList();
          
          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add,
                    size: 80,
                    color: VintageColors.lightText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: VintageColors.lightText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first note',
                    style: TextStyle(
                      fontSize: 14,
                      color: VintageColors.lightText,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: NoteCard(
                    note: notes[index],
                    onEdit: () => _editNote(context, notes[index]),
                    onDelete: () => _deleteNote(context, notes[index].id),
                  ),
                );
              },
            ),
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
        backgroundColor: VintageColors.primaryBrown,
        child: const Icon(
          Icons.add,
          color: VintageColors.creamWhite,
          size: 28,
        ),
      ),
    );
  }
}