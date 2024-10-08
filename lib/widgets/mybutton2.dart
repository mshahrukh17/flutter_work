// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Mybutton2 extends StatelessWidget {
  var buttontext;
  var elevation;
  final void Function() onpress;
 Mybutton2({super.key,
 this.buttontext, 
 required this.onpress,
 this.elevation
 });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: elevation,
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
       ));
  }
}