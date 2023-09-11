import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes_flutter/common_widget/form_note.dart';
import 'package:simple_notes_flutter/data/note_api.dart';
import 'package:simple_notes_flutter/model/note.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({super.key, required this.noteModel});

  final Note noteModel;

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  @override
  void initState() {
    super.initState();
    setFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Note Detail'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Note'),
                      content: const Text('Do you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            var response = await NoteApi.deleteNoteApi(
                                widget.noteModel.id);
                            //check the context is mounted or not
                            if (!mounted) return;
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content:
                                        Text('Note Deleted Successfully')));
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/listNoteScreen', ((route) => false));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text('Request Failed')));
                              Navigator.pop(context, 'OK');
                            }
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'CANCEL');
                          },
                          child: const Text('CANCEL'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: FormNote(noteModel: widget.noteModel),
    );
  }

  void setFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdd', false);
  }
}
