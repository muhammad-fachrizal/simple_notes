import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes_flutter/data/note_api.dart';
import 'package:simple_notes_flutter/main.dart';
import 'package:simple_notes_flutter/model/note.dart';

class FormNote extends StatefulWidget {
  const FormNote({super.key, required this.noteModel});

  final Note noteModel;

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _title = '';
  String _note = '';
  bool? isAdd;

  @override
  void initState() {
    super.initState();
    _noteController.text = widget.noteModel.note;
    _titleController.text = widget.noteModel.title;
    checkFlag();
  }

  @override
  Widget build(BuildContext context) {
    print('isAdd value inside build: $isAdd');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Text(widget.noteModel.id.toString()),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _titleController,
                minLines: 1,
                maxLines: 2,
                decoration: const InputDecoration(
                  // enabledBorder: const OutlineInputBorder(
                  //   borderSide: const BorderSide(color: Colors.grey, width: 2s.0),
                  // ),
                  labelText: 'Title',
                  //hintText: '',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 20.0),
                  ),
                ),
                //textDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  // decoration: InputDecoration.collapsed(
                  //   hintText: 'note',
                  // ),
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 20.0),
                    ),
                  ),
                  controller: _noteController,
                  maxLines: 999,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () async {
                    _title = _titleController.text;
                    _note = _noteController.text;
                    if (_note.trim().isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Empty Field'),
                            content: const Text('Note field cannot be empty'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      print('isAdd value inside save button: $isAdd');
                      // (isAdd!)
                      //     ? await addNewNote(context)
                      //     : await updateNote(context);
                      print(
                          'note: ${Note(id: widget.noteModel.id, title: _title, note: _note)}');
                      var response = (isAdd!)
                          ? await NoteApi.addNewNoteApi(_title, _note)
                          : await NoteApi.updateNoteApi(Note(
                              id: widget.noteModel.id,
                              title: _title,
                              note: _note));
                      print('statusCode: ${response.statusCode}');
                      //print('isMounted ${context.mounted}');
                      //check the context is mounted or not
                      if (!mounted) return;
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: (isAdd!)
                                  ? const Text('New Note Added Successfully')
                                  : const Text('Note Updated Successfully'),
                            ),
                          );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/listNoteScreen',
                          ((route) => false),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text('Request Failed')));
                        Navigator.pop(context, 'OK');
                      }
                    }
                  },
                  child: Text(
                    (isAdd ?? true) ? 'Add' : 'Update',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  void checkFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAdd = prefs.getBool('isAdd');
    });
    //isAdd = prefs.getBool('isAdd');
    print('isAdd value inside checkFlag(): $isAdd');
  }

  // Future<void> updateNote(BuildContext context) async {
  //   print('note: ${Note(id: widget.noteModel.id, title: _title, note: _note)}');
  //   var response = await NoteApi.updateNoteApi(
  //       Note(id: widget.noteModel.id, title: _title, note: _note));
  //   print('statusCode: ${response.statusCode}');
  //   print('isMounted ${context.mounted}');
  //   if (response.statusCode == 200 && context.mounted) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Update Note'),
  //           content: const Text('Note Updated Successfully'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pushNamedAndRemoveUntil(
  //                     context, '/listNoteScreen', ((route) => false));
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<void> addNewNote(BuildContext context) async {
  //   print('note: ${_title} _${_note}');
  //   var response = await NoteApi.addNewNoteApi(_title, _note);
  //   print('statusCode: ${response.statusCode}');
  //   print('isMounted ${context.mounted}');
  //   if (response.statusCode == 200 && context.mounted) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Add New Note'),
  //           content: const Text('New Note Added Successfully'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pushNamedAndRemoveUntil(
  //                     context, '/listNoteScreen', ((route) => false));
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
}
