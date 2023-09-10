import 'package:flutter/material.dart';
import 'package:simple_notes_flutter/model/note.dart';
import 'package:simple_notes_flutter/screens/add_note_screen.dart';
import 'package:simple_notes_flutter/screens/detail_note_screen.dart';
import 'package:simple_notes_flutter/screens/list_note_screen.dart';
import 'package:simple_notes_flutter/theme_manager/color_schemes.dart';

//late SharedPreferences prefs;
main() async {
  //prefs = await SharedPreferences.getInstance();
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
        // colorScheme: Theme.of(context).colorScheme.copyWith(
        //       primary: Color(0xFFCEDEBD),
        //       onPrimary: Colors.black,
        //       secondary: Color(0xFF9EB384),
        //     ),

        colorScheme: lightColorScheme,
        //primaryColor: lightColorScheme.primary,
      ),
      //colorSchemeSeed: const Color(0xFF5C8374),

      darkTheme: ThemeData(
        useMaterial3: true, colorScheme: darkColorScheme,
        //colorSchemeSeed: const Color(0xAA5C8374),
      ),
      // ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a blue toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      initialRoute: '/listNoteScreen',
      routes: {
        '/listNoteScreen': (context) => const ListNoteScreen(),
        '/addNoteScreen': (context) => const AddNoteScreen(),
        '/detailNoteScreen': (context) => DetailNoteScreen(
              noteModel: ModalRoute.of(context)?.settings.arguments as Note,
            ),
      },
      //home: const ListNote(),
    );
  }
}
