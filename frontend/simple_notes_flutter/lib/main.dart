import 'package:flutter/material.dart';
import 'package:simple_notes_flutter/model/note.dart';
import 'package:simple_notes_flutter/screens/add_note_screen.dart';
import 'package:simple_notes_flutter/screens/detail_note_screen.dart';
import 'package:simple_notes_flutter/screens/list_note_screen.dart';
import 'package:simple_notes_flutter/theme_manager/color_schemes.dart';

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      initialRoute: '/listNoteScreen',
      routes: {
        '/listNoteScreen': (context) => const ListNoteScreen(),
        '/addNoteScreen': (context) => const AddNoteScreen(),
        '/detailNoteScreen': (context) => DetailNoteScreen(
              noteModel: ModalRoute.of(context)?.settings.arguments as Note,
            ),
      },
    );
  }
}
