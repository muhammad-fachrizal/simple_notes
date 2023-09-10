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
    // String link = "https://express-simple-notes-6468.up.railway.app";
    // var response = await http
    //     .get(Uri.parse(link), headers: {"Accept": "application/json"});
    var response = await NoteApi.getAllNotesApi();
    var rb = response.body;
    var listJson = jsonDecode(rb)['note'] as List;

    if (response.statusCode == 200) {
      setState(
        () {
          listNote = listJson.map((e) => Note.fromJson(e)).toList();
          print('listNote: ${listNote.toString()}');
          print('listNote length: ${listNote.length}');
          //noteList = Note.fromJson(decode);
          // delivery = Delivery.fromJson(jsonDecode(rb));
          // print('delivery: ${delivery.toString()}');
          // print('deliveryNumber: ${delivery.deliveryNumber}');
          // print('stops: ${delivery.stops}');
          // print('stops length: ${delivery.stops.length}');

          //Iterable listIterable = json.decode(res.body);
          // deliveryList =
          //     dataDecode.map((model) => Delivery.fromJson(model)).toList();
          //listMap = list.entries.map((entry) => entry.value).toList();
          //print('deliveryList: $deliveryList');
        },
      );
    }

    return listNote;
  }

  @override
  void initState() {
    super.initState();
    //getData();
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
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: getAllNotes,
            //child: SizedBox(
            //height: MediaQuery.of(context).size.height,
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
                // id: listNote[index].id,
                // title: listNote[index].title,
                // note: listNote[index].note);
              },
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            //),
          ),
          // GridView.builder(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     mainAxisSpacing: 16,
          //     crossAxisSpacing: 16,
          //     childAspectRatio: 3 / 2,
          //     crossAxisCount: (screenWidth <= 600) ? 2 : 4,
          //   ),
          //   itemBuilder: (context, index) {
          //     return NoteCardWidget(
          //         title: listNote[index].title, note: listNote[index].note);
          //   },
          //   itemCount: listNote.length,
          // ),
          // GridView.count(
          //   crossAxisSpacing: 16,
          //   mainAxisSpacing: 16,
          //   crossAxisCount: (screenWidth <= 600) ? 2 : 4,
          //   children: const [
          //     NoteCardWidget(title: title, note: note)
          //   ],
          // ),
          // child: Column(
          //
          // children: [
          //     ListView.builder(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       itemCount: listNote.length,
          //       itemBuilder: (context, index) {
          //         return ListTile(
          //           title: Text(listNote[index].title),
          //           subtitle: Text(listNote[index].note),
          //         );
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addNoteScreen',
          );
        },
        shape: RoundedRectangleBorder(
            //side: BorderSide(width: 3, color: Colors.brown),
            borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
