import 'package:flutter/material.dart';
import 'package:notes/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  // hive databse
  final db = HiveDatabase();

  // overall list of notes
  List<Note> allNotes = [];

  // init the list
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // update note
  void updateNote(Note note, String text) {
    // go thru all list of notes
    for (int i = 0; i < allNotes.length; i++) {
      // find relevant note
      if (allNotes[i].id == note.id) {
        // replace text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
