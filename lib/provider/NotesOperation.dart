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

    notifyListeners();
  }

  void removeNote(id) {
    _notes.removeWhere((note) => note.id == id);

    notifyListeners();
  }

  void editNote(id, title, description) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = Note(id, title, description);

    notifyListeners();
  }
}