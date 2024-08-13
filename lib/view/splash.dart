// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:appfood2/view/Admin/Admindashboard.dart';
import 'package:appfood2/view/LoginPage.dart';
import 'package:appfood2/view/UserView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // Get.to(LoginPage());
      checkUser();
    },);
  }

   checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userCheck = prefs.getBool("Login")?? false;
    if(userCheck){
      var userType = prefs.getString("usertype");
      if(userType=="admin"){
        Get.offAll(AdminDashboard());
      }
      else{
        print("user");
        Get.offAll(userview());
      }
    }
    else{
      print("User not logging");
      Get.offAll(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }
}