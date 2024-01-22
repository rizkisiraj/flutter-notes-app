import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/provider/NotesOperation.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  NoteFormPage({Key? key}): super(key: key);

  final TextEditingController _titleController = new TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final QuillController _quillController = QuillController.basic();

  @override
  void dispose() {
    _titleController.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                // print(jsonEncode(_quillController.document.toDelta().toJson()));
                Provider.of<NotesOperation>(context, listen: false).addNote(_titleController.text, _quillController.document.toPlainText(), jsonEncode(_quillController.document.toDelta().toJson()));
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
                              controller: _titleController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your title...'
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            ),
                          Expanded(
                              child: Container(
                                  child: QuillEditor(
                                    focusNode: myFocusNode,
                                    scrollController: ScrollController(),
                                    configurations: QuillEditorConfigurations(
                                      autoFocus: false,
                                      expands: false,
                                      padding: const EdgeInsets.only(bottom: 8),
                                      scrollable: true,
                                      placeholder: "Write your notes...",
                                      controller: _quillController,
                                      readOnly: false,
                                      sharedConfigurations: const QuillSharedConfigurations(
                                        locale: Locale('en'),
                                      ),
                                    ),
                                  ),
                              ),
                              // child: QuillEditor.basic(controller: _quillController, readOnly: false)
                            ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _quillController,
              multiRowsDisplay: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('de'),
              ),
            ),
          ),
          // )
        ],
      ),
    );
  }

}