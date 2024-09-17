import 'package:flutter/material.dart';
import 'package:noteapp/screen/myNotespage.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  
  runApp(const MainApp());
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
