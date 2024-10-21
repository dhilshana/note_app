// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/providers/noteProvider.dart';
import 'package:noteapp/screen/addingNotespage.dart';

import 'package:noteapp/utils/constants.dart';
import 'package:noteapp/widgets/customCard.dart';
import 'package:provider/provider.dart';

class MyNotesPage extends StatefulWidget {
  String? title;
  String? desc;
  String? imagePath;
  MyNotesPage({super.key, this.title, this.desc});

  @override
  State<MyNotesPage> createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  bool isAll = true;
  bool isImportant = false;
  bool marked = false;

  void reload(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {


   

    final provider = context.watch<NoteProvider>();

     final  impList =  provider.notes.where((element) => element['isMarked']==true,).toList();
   

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgcolor,
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My \nNotes",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Text(
                      "Logo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAll = true;
                        isImportant = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "All",
                          style: TextStyle(
                              color: isAll ? Colors.white : Colors.white70,
                              fontSize: 25),
                        ),
                        SizedBox(height: 5), // Spacing between text and line
                        Container(
                          height: 2,
                          width: 90,
                          color: isAll ? Colors.white : Colors.white70,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isImportant = true;
                        isAll = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Important",
                          style: TextStyle(
                              color:
                                  isImportant ? Colors.white : Colors.white70,
                              fontSize: 25),
                        ),
                        SizedBox(height: 5), // Spacing between text and line
                        Container(
                          height: 2,
                          width: 90,
                          color: isImportant ? Colors.white : Colors.white70,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: isImportant? 
                     ListView.builder(
                          itemCount: impList.isNotEmpty ? impList.length : 1,
                          itemBuilder: (context, index) {
                            if (impList.isNotEmpty) {
                              final note = impList[index];
                              return CustomCard(note: note,impNote: impList,index: index,onReload: reload,);
                            }
                          },
                      ):

                    ListView.builder(
                          itemCount: provider.notes.isNotEmpty ? provider.notes.length : 1,
                          itemBuilder: (context, index) {

                           
                            if (provider.notes.isNotEmpty) {
                              final note = provider.notes[index];

                                  
                              return CustomCard(note: note,impNote: impList,index: index,onReload: reload);
                            
                            }
                          },
                        )
                        
                      ),
           
           
           
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddingNotesPage()));
          },
          backgroundColor: Colors.white70,
          shape: StadiumBorder(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
