import 'package:flutter/cupertino.dart';
import 'package:prak_pbm_09/models/note.dart';

class NotesOperation with ChangeNotifier {
  // List of Notes
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('First Note', 'First Note Description');
  }

  void addNewNote(String title, String description) {
    // Note object
    Note note = Note(title, description);
    _notes.add(note);
    notifyListeners();
  }
}
