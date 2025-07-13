import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/NotesModel.dart';

class NoteService {
  static const _boxName = 'notes';
  late Box<Note> _box;

  ValueListenable<Box<Note>> get notesListenable => _box.listenable();

  Future<void> init() async {
    _box = await Hive.openBox<Note>(_boxName);
  }

  List<Note> getNotes() {
    return _box.values.toList();
  }

  void addNote(Note note) {
    _box.put(note.id, note);
  }
}