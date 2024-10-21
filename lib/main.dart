import 'package:flutter/material.dart';
import 'package:noteapp/providers/noteProvider.dart';
import 'package:noteapp/screen/myNotespage.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  
  runApp(ChangeNotifierProvider(
    create: (context) => NoteProvider(),
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyNotesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
