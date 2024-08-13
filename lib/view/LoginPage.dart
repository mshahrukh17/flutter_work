// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable

import 'package:appfood2/Controller/AuthController.dart';
import 'package:appfood2/widgets/mybutton.dart';
import 'package:appfood2/widgets/TextFormField.dart';
import 'package:appfood2/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool showpassword = false;

  void userlogin(){
      authController.loginuser(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Image.asset("assets/images/logo.jpg",height: MediaQuery.of(context).size.height *0.3,),
                  textwidget(
                    text: "Login Account",
                    fontsize: 50.0,
                    fontfamily: "font1",
                    fontweight: FontWeight.bold,
                  ),
                  TextFormFieldWidget(
                    controller: emailController,
                    obscuretext: false,
                    labeltext: "Your Email",
                    prefixicon: Icon(Icons.email),
                    validator: (value){
                      if (value==null || value.isEmpty) {
                        return "Enter your Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormFieldWidget(
                    controller: passwordController,
                    obscuretext: !showpassword,
                    suffixicon: IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon: Icon(showpassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded)),
                    labeltext: "Your Password",
                    prefixicon: Icon(Icons.lock),
                    validator: (value) {
                      if (value==null || value.isEmpty) {
                        return "Please Enter your Password";
                      }
                      else if(value.length < 6){
                        return "Password must be 6 letters or above";
                      }
                    },
                  ),
                  SizedBox(height: 12.0,),
                  controller.isloading ? CircularProgressIndicator():
                  Mybutton(
                    onpress: (){
                      if (_formkey.currentState!.validate()) {
                        // message("Success", "Success");
                        userlogin();
                      } else {
                        message("Error", "Please Enter these fields");
                      }
                    },
                    buttontext: "Login",
                    )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
