// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  var buttontext;
  final void Function() onpress;
 Mybutton({super.key,
 this.buttontext, 
 required this.onpress
 });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 20,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: Colors.black,
          shadowColor: Colors.black,
          side: BorderSide(
            color: Colors.black,
             width: 4,
              style: BorderStyle.solid)
        ),
        onPressed: (){
          onpress();
        },
         child: Text(buttontext,
         style: TextStyle(
          fontFamily: "font1",
          fontWeight: FontWeight.bold,
          fontSize: 20.0
         ),
         )));
  }
}