import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> notes = [];

  void addNotes(Map<String, dynamic> value) {
    notes.add(value);
    notifyListeners();
  }

  void removeNote(Map<String, dynamic> value) {
    var noteToRemove = notes.firstWhere(
      (note) =>
          note['title'] == value['title'] &&
          note['description'] == value['description'],
    );

    if (noteToRemove != null) {
      notes.remove(noteToRemove);
    }
    notifyListeners();
  }

  void updateNote({required Map<String, dynamic> value,required Map<String,dynamic> oldvalue}) {
    var noteToUpdate = notes.firstWhere((note) => 
      note['title'] == oldvalue['title'] &&
      note['description'] == oldvalue['description'],
    );
    int index = notes.indexOf(noteToUpdate);
    print('---------$index');
    notes[index] = value;
    notifyListeners();
  }
}
