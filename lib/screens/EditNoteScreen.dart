import 'package:flutter/material.dart';
import 'package:notes_app/constants/Colors.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:notes_app/services/NoteService.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomTextField.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteService noteService;
  final Note note;

  const EditNoteScreen({
    super.key,
    required this.noteService,
    required this.note,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  void _updateNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      final updatedNote = Note(
        id: widget.note.id,
        title: title,
        content: content,
        createdAt: widget.note.createdAt,
      );
      widget.noteService.updateNote(updatedNote);
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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VintageColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Edit Note',
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
                      text: 'Update Note',
                      onPressed: _updateNote,
                      backgroundColor: VintageColors.buttonEdit,
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