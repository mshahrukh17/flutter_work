// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_returning_null_for_void, file_names

import 'package:appfood2/Controller/AuthController.dart';
import 'package:appfood2/widgets/mybutton.dart';
import 'package:appfood2/widgets/TextFormField.dart';
import 'package:appfood2/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/message.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  var authController = Get.put(AuthController());
  final _formkey = GlobalKey<FormState>();
  bool shoepassword = false;

  void signup() {
    authController.signupuser(
    emailController.text, passwordController.text, nameController.text);
    emailController.clear();
    nameController.clear();
    passwordController.clear();
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
                     Image.asset("assets/images/logo.jpg",height: MediaQuery.of(context).size.height *0.2,),
                    textwidget(
                      text: "Sign up",
                      fontsize: 50.0,
                      fontweight: FontWeight.bold,
                      fontfamily: "font1",
                    ),
                    TextFormFieldWidget(
                      controller: nameController,
                      labeltext: "Your Name",
                      prefixicon: Icon(Icons.mail),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormFieldWidget(
                      controller: emailController,
                      labeltext: "Your Email",
                      prefixicon: Icon(Icons.mail),
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (value == null || value.isEmpty) {
                          return "Email Required";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "Email is invalid form";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormFieldWidget(
                      obscuretext: !shoepassword,
                      controller: passwordController,
                      labeltext: "Your Password",
                      prefixicon: Icon(Icons.lock),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password Required";
                        } else if (value.length < 6) {
                          return "Password must be 6 letters or above!";
                        }
                        return null;
                      },
                      suffixicon: IconButton(
                          onPressed: () {
                            setState(() {
                              shoepassword = !shoepassword;
                            });
                          },
                          icon: Icon(shoepassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    controller.isloading
                        ? CircularProgressIndicator()
                        : Mybutton(
                            buttontext: "Sign Up",
                            onpress: () {
                              if (_formkey.currentState!.validate()) {
                                message("Success", "Information is valid form");
                                signup();
                              }
                               else if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                                 if (nameController.text.isEmpty) {
                                  message("Error", "Name is required");
                                } else if (emailController.text.isEmpty) {
                                  message("Error", "Email is required");
                                } else if (passwordController.text.isEmpty) {
                                  message("Error", "Password required");
                                } else {
                                  return null;
                                }
                              }
                              return null;
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
