import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/provider/NotesOperation.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {

  final Note note;
  DetailPage({Key? key, required this.note}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {

  bool _isEditing = false;
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();
  late FocusNode _descFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _descController.text = widget.note.description;
    _descFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _descFocusNode.dispose();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _isEditing ? [
          IconButton(
              onPressed: (){
                Provider.of<NotesOperation>(context, listen: false).editNote(widget.note.id, _titleController.text, _descController.text);
                setState(() {
                  _isEditing = false;
                });
              },
              icon: const Icon(
                Icons.check,
              )
          )
        ] : [
          IconButton(
              onPressed: (){
                FocusScope.of(context).requestFocus(_descFocusNode);
                setState(() {
                  _isEditing = true;
                });
                // var snackBar = SnackBar(content: Text('Editing mode'));
                // // Step 3
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(
                Icons.edit
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
                child: Hero(
                  tag: 'note ${widget.note.id}',
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
                              readOnly: !_isEditing,
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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Material(
                                type: MaterialType.transparency,
                                child: TextField(
                                  controller: _descController,
                                  readOnly: !_isEditing,
                                  focusNode: _descFocusNode,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "Write your notes here....",
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ),
          // )
        ],
      ),
    );
  }
  
}