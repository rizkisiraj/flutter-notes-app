import 'package:flutter/cupertino.dart';
import 'package:notes_app/model/Note.dart';

class NotesOperation extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  void addNote(String title, String description) {
    Note newNote = Note(DateTime.now().millisecondsSinceEpoch,title, description);

    _notes.add(newNote);
  }

  void removeNote(id) {
    _notes.removeWhere((note) => note.id == id);
  }
}