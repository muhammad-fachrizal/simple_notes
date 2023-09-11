// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  int id;
  String title;
  String note;
  Note({
    required this.id,
    this.title = '',
    required this.note,
  });

  Note copyWith({
    int? id,
    String? title,
    String? note,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] ?? '',
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(dynamic json) => Note(
      id: json['id'] as int,
      title: json['title'] ?? '',
      note: json['note'] as String);

  @override
  String toString() => 'Note(id: $id, title: $title, note: $note)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ note.hashCode;
}
