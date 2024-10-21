import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/screen/controller.dart';
import 'package:noteapp/screen/notepage.dart';

class CustomCard extends StatefulWidget {
  Map<String, dynamic> note;
  List impNote;
  int index;
  VoidCallback? onReload; 
  CustomCard(
      {super.key,
      required this.note,
      required this.impNote,
      required this.index,
      this.onReload});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotePage(
                      title: widget.note['title'],
                      desc: widget.note['description'],
                      imagePath: widget.note['image'],
                      index: widget.index,
                    ))).then((updatedNote) {
                      widget.onReload!();
          if (updatedNote != null) {
            // Update the note with new data
            
            setState(() {
              widget.note['title'] = updatedNote['title'];
              widget.note['description'] = updatedNote['description'];
              widget.note['image'] = updatedNote['image'];
            });
          }
        
        });
        
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(179, 156, 153, 153),
              backgroundImage: widget.note['image'] != null
                  ? FileImage(File(widget
                      .note['image'])) // Load the image from the file path
                  : null,
              child: widget.note['image'] == null
                  ? Icon(Icons.image, color: Colors.black)
                  : null,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.note['title'] ?? 'Title'),
                Text(widget.note['description'] ?? "Lorem one two three")
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(widget.note['isMarked']
                  ? Icons.bookmark
                  : Icons.bookmark_outline),
              onPressed: () {
                setState(() {
                  widget.note['isMarked'] = !widget.note['isMarked'];
                  if (widget.note['isMarked'] == true)
                    widget.impNote.add(widget.note);
                  else
                    widget.impNote.remove(widget.note);
                  print(widget.impNote);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
