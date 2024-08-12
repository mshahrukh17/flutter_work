// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';

import 'package:appfood2/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminDishController extends GetxController{
  bool isloading = false;
  var alldish = [];
  var dropdownvalue = "";
  var selectdropdownkey = "";
  final ImagePicker _picker = ImagePicker();
  var image;
  var filepath = "";
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  
  setloading(vlaue){
    isloading = vlaue;
    update();
  }

  setdropdown(value){
    dropdownvalue = value["name"];
    selectdropdownkey = value["itemkey"];
    update();
  }

  selectimage(source) async {
   final XFile? file = await _picker.pickImage(source: source);
   if (file != null) {
    print(file.path);
    image = File(file.path);
    filepath = file.path;
    print(filepath.toString().split("/").last);
   } 
   update();
  }

  getalldishes() async {
    setloading(true);
    CollectionReference dishes = FirebaseFirestore.instance.collection("items");
    await dishes.where("status", isEqualTo: true).get().then((QuerySnapshot snapshot){
      final alldata = snapshot.docs.map((doc) =>doc.data()).toList();

      alldish = alldata;
    });
    setloading(false);
    update();
  }

  adddishes() async {
    if (image==null) {
      message("Error", "Please Enter Dish Image");
    }
    else if(namecontroller.text.isEmpty) {
      message("Error", "Please Enter Dish Name");
    }
     else if(pricecontroller.text.isEmpty) {
      message("Error", "Please Enter Dish Price");
    }
     else if(dropdownvalue == "") {
      message("Error", "Please Enter Category");
    }
    else{
      var filename = filepath.toString().split("/").last;
      final storage = FirebaseStorage.instance.ref("");
      final imagesRef = storage.child("dishes/${filename}");
      await imagesRef.putFile(image);
      var downloadurl = await imagesRef.getDownloadURL(); 
      print(downloadurl);
    }
  }
}