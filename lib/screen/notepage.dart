import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noteapp/providers/noteProvider.dart';
import 'package:noteapp/screen/controller.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  String title;
  String desc;
  String? imagePath;
  int? index;
  
  NotePage({super.key, required this.title, required this.desc, this.imagePath,required this.index});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descController = TextEditingController(text: desc);

    

    final provider = context.watch<NoteProvider>();

    


    
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 245, 199),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context, );
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.mode_edit_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text('Edit your title and description'),
                                content: Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: titleController,
                                        decoration:
                                            InputDecoration(hintText: "Title"),
                                      ),
                                      TextField(
                                        controller: descController,
                                        decoration: InputDecoration(
                                            hintText: "Description"),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Update title and description
                                     String newTitle = titleController.text;
                                     String  newDesc = descController.text;
                                      context.read<NoteProvider>().updateNote(value: {'title':newTitle,'description':newDesc,'isMarked':false},oldvalue:{'title':title,'description':desc} );
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outlined),
                        onPressed: () {
                         context.read<NoteProvider>().removeNote({'title':title,'description':desc});

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 30),
              Text(
                provider.notes[index!]['title'],
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(provider.notes[index!]['description']),
            ],
          ),
        ),
      ),
    );
  }
}
