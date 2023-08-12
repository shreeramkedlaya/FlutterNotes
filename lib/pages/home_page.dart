import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  // create a new note
  void createNewNote() {
    // create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //create a new note
    Note newNote = Note(id: id, text: '');

    // go to edit the note
    goToNotePage(newNote, true);
  }

  // delete note
  void deleteNote(Note note) {
    Provider.of(context, listen: false).deleteNode(note);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            isNewNote: isNewNote,
            note: note,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (BuildContext context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            // heading
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            // list of notes
            if (value.getAllNotes().isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    'Nothing here',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              CupertinoListSection.insetGrouped(
                children: List.generate(
                  value.getAllNotes().length,
                  (index) => CupertinoListTile(
                    title: Text(
                      value.getAllNotes()[index].text,
                    ),
                    onTap: () =>
                        goToNotePage(value.getAllNotes()[index], false),
                    trailing: IconButton(
                      icon: const Icon(Icons.folder_delete_rounded),
                      onPressed: () => deleteNote(value.getAllNotes()[index]),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
