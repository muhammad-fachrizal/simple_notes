import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_notes_flutter/common_widget/note_card_widget.dart';
import 'package:simple_notes_flutter/data/note_api.dart';
import 'package:simple_notes_flutter/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListNoteScreen extends StatefulWidget {
  const ListNoteScreen({super.key});

  @override
  State<ListNoteScreen> createState() => _ListNoteScreenState();
}

class _ListNoteScreenState extends State<ListNoteScreen> {
  List<Note> listNote = [];

  Future<List<Note>> getAllNotes() async {
    listNote.clear();
    var response = await NoteApi.getAllNotesApi();
    var rb = response.body;
    var listJson = jsonDecode(rb)['note'] as List;

    if (response.statusCode == 200) {
      setState(
        () {
          listNote = listJson.map((e) => Note.fromJson(e)).toList();
        },
      );
    }

    return listNote;
  }

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Simple Notes'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: getAllNotes,
                child: MasonryGridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (screenWidth <= 600) ? 2 : 4,
                  ),
                  itemCount: listNote.length,
                  itemBuilder: (context, index) {
                    return NoteCardWidget(
                      noteModel: Note(
                          id: listNote[index].id,
                          title: listNote[index].title,
                          note: listNote[index].note),
                    );
                  },
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addNoteScreen',
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
