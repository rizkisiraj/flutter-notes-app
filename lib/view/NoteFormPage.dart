import 'package:flutter/material.dart';
import 'package:notes_app/provider/NotesOperation.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  const NoteFormPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleText = '';
    String descriptionText = '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                Provider.of<NotesOperation>(context, listen: false).addNote(titleText, descriptionText);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
              )
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/3dwork.png'), scale: 1.2)
              )
          ),
          Expanded(
            child: Material(
                type: MaterialType.transparency,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: ClipRRect(
                      child: Column(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your title...'
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600
                              ),
                              onChanged: (value) {
                                titleText = value;
                              },
                            ),
                            ),
                          Expanded(
                            child: Material(
                              type: MaterialType.transparency,
                              child: TextField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14
                                ),
                                decoration: InputDecoration(
                                    hintText: "Write your notes here....",
                                    border: InputBorder.none
                                ),
                                onChanged: (value) {
                                  descriptionText = value;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          // )
        ],
      ),
    );
  }

}