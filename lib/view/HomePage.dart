import 'package:flutter/material.dart';
import 'package:notes_app/provider/NotesOperation.dart';
import 'package:notes_app/view/DetailPage.dart';
import 'package:notes_app/view/NoteFormPage.dart';
import 'package:notes_app/model/Note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Column(
              children: [
               const Row(
                  children: [
                    Flexible(
                      child: Text(
                      "Hello, what's on your mind? 👋",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                      ),
                                        ),
                    ),
                  ]
                ),
                Consumer<NotesOperation>(
                  builder: (context, NotesOperation notes, child) {
                    print("Number of notes: ${notes.getNotes.length}");
                    return Expanded(
                      child: ListView.builder(
                        itemCount: notes.getNotes.length,
                        padding: EdgeInsets.only(top: 24),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return NoteCard(notes.getNotes[index]);
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NoteFormPage()));
          },
          child: const Icon(Icons.add, size: 30),
        ),
      );
    }
}

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(note: note)));
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context, builder:
            (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              onTap: () {
                Provider.of<NotesOperation>(context, listen: false).removeNote(note.id);
                Navigator.pop(context);
              },
              title: Text(
                'Delete',
                style: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Hero(
        tag: 'note ${note.id}',
        child: Container(
            height: 132,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              color: Theme.of(context).colorScheme.surfaceVariant,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: Text(
                          note.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        )
                    ), Container(
                      width: double.infinity,
                        child: Text(note.descriptionPlainText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}