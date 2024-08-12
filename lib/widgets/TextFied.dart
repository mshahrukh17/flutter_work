// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class TextFieldWidget2 extends StatelessWidget {
  TextEditingController controller;
  var suffixicon;
  var prefixicon;
  var hinttext;
  var width;
   TextFieldWidget2({super.key,
  required this.controller,
  this.prefixicon,
  this.suffixicon,
  this.hinttext,
  this.width
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        child: TextFormField(
            controller: controller,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              suffixIcon:suffixicon,
              prefixIcon: prefixicon,
              hintText: hinttext,
             border: InputBorder.none,
             enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black
              ),
              borderRadius: BorderRadius.circular(8)
             ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 4,
                )
              ),
            ),
          ),
      ),
    );
  }
}