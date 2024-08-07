// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class textwidget extends StatelessWidget {
    var text;
    var fontsize;
    var fontweight;
    var fontfamily;
    textwidget({super.key,
    this.text,  
    this.fontsize, 
    this.fontfamily,
    this.fontweight = false,
   });

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      color: Colors.black,
      fontSize: fontsize,
      fontWeight: fontweight,
      fontFamily: fontfamily
    ),
    );
     
  }
}
