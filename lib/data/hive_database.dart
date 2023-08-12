import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/note.dart';

class HiveDatabase {
  // ref hiv box
  final _myBox = Hive.box('note_database');

  // load notes

  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    // if there exist notes, return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        // create individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        // add to list
        savedNotesFormatted.add(individualNote);
      }
    } else {
      savedNotesFormatted.add(
        Note(id: 1, text: 'first note'),
      );
    }
    return savedNotesFormatted;
  }

  void savedNote(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    // each note has an id and an text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    // store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
