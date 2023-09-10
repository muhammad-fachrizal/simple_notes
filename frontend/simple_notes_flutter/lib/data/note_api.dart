import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_notes_flutter/model/note.dart';

class NoteApi {
  static Future getAllNotesApi() async {
    String link = "https://express-simple-notes-6468.up.railway.app";
    //String link = "http://localhost:3000/";
    return await http
        .get(Uri.parse(link), headers: {"Accept": "application/json"});
  }

  static Future updateNoteApi(Note noteModel) async {
    String link =
        "https://express-simple-notes-6468.up.railway.app/update/${noteModel.id}";
    //String link = "http://localhost:3000/update/${noteModel.id}";
    Map body = {"title": noteModel.title, "note": noteModel.note};
    return await http.patch(Uri.parse(link),
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
  }

  static Future addNewNoteApi(String title, String note) async {
    String link = "https://express-simple-notes-6468.up.railway.app/add";
    //String link = "http://localhost:3000/add";
    Map body = {"title": title, "note": note};
    return await http.post(Uri.parse(link),
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
  }

  static Future deleteNoteApi(int id) async {
    String link = "https://express-simple-notes-6468.up.railway.app/delete/$id";
    //String link = "http://localhost:3000/delete/$id";
    return await http
        .delete(Uri.parse(link), headers: {"Accept": "application/json"});
  }
}
