// ignore_for_file: camel_case_types, prefer_const_constructors, file_names, unused_element

import 'package:appfood2/view/LoginPage.dart';
import 'package:appfood2/widgets/mybutton2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userview extends StatefulWidget {
  const userview({super.key});

  @override
  State<userview> createState() => _userviewState();
}

class _userviewState extends State<userview> {
  var name = "";
  @override
  void initState() { 
    super.initState();
    setdata();
  }
  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    setState(() {
    });
  }

    logout() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAll(LoginPage());
      setState(() {
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hii ${name.toString()}"),
        actions: [
          Mybutton2(onpress: (){
            logout();
          }, buttontext: "Logout",)
        ],
      ),
    );
  }
}