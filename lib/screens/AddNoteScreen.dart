import 'package:flutter/material.dart';
import 'package:notes_app/constants/Colors.dart';
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
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      final note = Note(
        id: const Uuid().v4(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
      widget.noteService.addNote(note);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both title and content'),
          backgroundColor: VintageColors.vintageRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VintageColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(
            color: VintageColors.creamWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: VintageColors.primaryBrown,
        elevation: 4,
        shadowColor: VintageColors.shadowColor,
        iconTheme: const IconThemeData(color: VintageColors.creamWhite),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: VintageColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: VintageColors.shadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _titleController,
                      label: 'Note Title',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _contentController,
                      label: 'Note Content',
                      maxLines: 10,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Save Note',
                      onPressed: _saveNote,
                      backgroundColor: VintageColors.buttonPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}