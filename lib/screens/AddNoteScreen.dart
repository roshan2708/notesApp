import 'package:flutter/material.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:notes_app/services/NoteService.dart';
import 'package:uuid/uuid.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomTextField.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteService noteService;

  const AddNoteScreen({super.key, required this.noteService});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final note = Note(
        id: const Uuid().v4(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
      widget.noteService.addNote(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: _titleController, label: 'Title'),
            const SizedBox(height: 10),
            CustomTextField(controller: _contentController, label: 'Content'),
            const SizedBox(height: 20),
            CustomButton(text: 'Save Note', onPressed: _saveNote),
          ],
        ),
      ),
    );
  }
}
