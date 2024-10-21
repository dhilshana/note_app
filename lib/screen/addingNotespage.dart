import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/providers/noteProvider.dart';
import 'package:noteapp/screen/myNotespage.dart';
import 'package:provider/provider.dart';

class AddingNotesPage extends StatefulWidget {
  const AddingNotesPage({super.key});

  @override
  State<AddingNotesPage> createState() => _AddingNotesPageState();
}

class _AddingNotesPageState extends State<AddingNotesPage> {
TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();


File? image;
final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Convert the picked file to a File object
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(backgroundColor:const Color.fromARGB(255, 242, 245, 199) ,),
      backgroundColor: const Color.fromARGB(255, 242, 245, 199),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: image == null ? Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.black,
                  ):null,
                  backgroundImage: image != null?FileImage(image!):null,
                ),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  floatingLabelStyle: TextStyle(color: Colors.black), 
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: "Discription",
                  floatingLabelStyle: TextStyle(color: Colors.black), 
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                String title = titleController.text;
                String desc = descController.text;
                if(title.isNotEmpty && desc.isNotEmpty) {
                  context.read<NoteProvider>().addNotes({'title':title,'description':desc,'image':image?.path,'isMarked':false});
                  Navigator.pop(context);
                  
                } else {
              
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You should give the title and description')));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Save",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
