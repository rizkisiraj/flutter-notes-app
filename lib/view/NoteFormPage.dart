import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:notes_app/helpers/helper.dart';
import 'package:notes_app/provider/NotesOperation.dart';
import 'package:provider/provider.dart';

import '../model/ChatResponse.dart';
import '../services/api_service.dart';

class NoteFormPage extends StatelessWidget {
  NoteFormPage({Key? key}): super(key: key);

  final OpenAIService openAIService = OpenAIService();
  final TextEditingController _titleController = new TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final QuillController _quillController = QuillController.basic();
  final _quillScrollController = ScrollController();

  void submitQuery(String userInput, BuildContext context) async {
    try {
      showAlertDialog(true, context);
      ChatResponse chatResponse = await openAIService.fetchChatResponse(userInput);
      print(chatResponse);
      showAlertDialog(false, context);
      myFocusNode.unfocus();
      // Ensure the QuillController is not null and the document is not null.
      if (_quillController != null && _quillController.document != null) {
        _insertText(chatResponse.content);
      } else {
        // Handle the case where the QuillController is not ready.
      }
    } catch(e) {
      print("Error: ${e.toString()}");
      showAlertDialog(false, context);
    }
  }

  void _insertText(String responseText) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    var color = isDarkMode ? "#007FFF" : "#F0F8FF";

    final Map<String, dynamic> attributes = {
      'background': color, // Example: Yellow color in HEX format
    };
    final int cursorPosition = _quillController.selection.baseOffset;
    final Delta delta = Delta()
        ..retain(cursorPosition)
        ..insert("\n")
        ..insert(responseText, attributes);
    _quillController.document.compose(delta, ChangeSource.local);

    final int newCursorPosition = _quillController.document.length - 1;
    _quillController.updateSelection(TextSelection(baseOffset: newCursorPosition, extentOffset: newCursorPosition), ChangeSource.local);
    myFocusNode.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_quillScrollController.hasClients) {
        _quillScrollController.animateTo(
          _quillScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }
  
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
          ),
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text("Summarize"), onTap: () {
              submitQuery(_quillController.document.toPlainText(), context);
            },)
          ])
        ],
      ),
      body: Column(
        children: [
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
                                    scrollController: _quillScrollController,
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