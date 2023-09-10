import 'package:flutter/material.dart';
import 'package:simple_notes_flutter/model/note.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({super.key, required this.noteModel});

  final Note noteModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //setFlag();
        Navigator.pushNamed(context, '/detailNoteScreen',
            arguments: Note(
                id: noteModel.id,
                title: noteModel.title,
                note: noteModel.note));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blueGrey, width: 2.0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                noteModel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 2,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                noteModel.note,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            // Expanded(
            //   flex: 1,
            //   child: Text(
            //     title,
            //     style:
            //         const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            //   ),
            // ),
            // Expanded(
            //   flex: 3,
            //   child: Text(
            //     note,
            //     style: const TextStyle(fontSize: 14),
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // void setFlag() {
  //   //final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isAdd', false);
  //   bool? isAdd = prefs.getBool('isAdd');
  //   print('isAdd value inside setFlag(): $isAdd');
  // }
}
