// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, avoid_print, unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:appfood2/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminDishController extends GetxController {
  bool isloading = false;
  var alldish = [];
  var dropdownvalue = "";
  var selectdropdownkey = "";
  final ImagePicker _picker = ImagePicker();
  var image;
  var filepath = "";
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  var selectdish = [];

  setloading(value) {
    isloading = value;
    update();
  }

  setdropdown(value) {
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
    await dishes
        .where("status", isEqualTo: true)
        .get()
        .then((QuerySnapshot snapshot) {
      final alldata = snapshot.docs.map((doc) => doc.data()).toList();
      var alloption = {"catkey": "", "name": "All", "status": true};
      alldata.insert(0, alloption);

      alldish = alldata;
    });
    setloading(false);
    update();
  }

  adddishes() async {
    if (image == null) {
      message("Error", "Please Enter Dish Image");
    } else if (namecontroller.text.isEmpty) {
      message("Error", "Please Enter Dish Name");
    } else if (pricecontroller.text.isEmpty) {
      message("Error", "Please Enter Dish Price");
    } else if (dropdownvalue == "") {
      message("Error", "Please Enter Category");
    }else if(dropdownvalue== "All"){
      message("Error", "Dish can not added in this category");
    }
     else {
      var filename = filepath.toString().split("/").last;
      final storage = FirebaseStorage.instance.ref("");
      final imagesRef = storage.child("dishes/${filename}");
      await imagesRef.putFile(image);
      var downloadurl = await imagesRef.getDownloadURL();
      print(downloadurl);

      var key = FirebaseDatabase.instance.ref("dish").push().key;
      var dishobj = {
        "dishname": namecontroller.text,
        "dishprice": pricecontroller.text,
        "dishkey": key,
        "categoryname": dropdownvalue,
        "categorykey": selectdropdownkey,
        "dishimage": downloadurl
      };
      CollectionReference dishes =
          FirebaseFirestore.instance.collection("dishes");
      await dishes.doc(key).set(dishobj);
      message("Success", "New Dish Added");
    }
  }

  getdishes(index) async {
    print(alldish[index]);
    if (alldish[index]["catkey"] == "") {
      CollectionReference dishes =
          FirebaseFirestore.instance.collection("dishes");
          await dishes.get().then((QuerySnapshot snapshot){
            final alldishdata = snapshot.docs.map((doc) => doc.data()).toList();
            selectdish = alldishdata;
          });
    } else {
      CollectionReference dishes =
          FirebaseFirestore.instance.collection("dishes");
      await dishes
          .where("categorykey", isEqualTo: alldish[index]["itemkey"])
          .get()
          .then((QuerySnapshot snapshot){
            final alldishdata = snapshot.docs.map((doc) => doc.data()).toList();
            selectdish = alldishdata;
            print(alldishdata);
            // update();
          });
    }
    update();
  }

  deletdish(index) async {
    CollectionReference dishes = FirebaseFirestore.instance.collection("dishes");
    await dishes.doc(selectdish[index]["dishkey"]).delete();
    selectdish.removeAt(index);
    message("Success", "Dish Deleted");
    update();
  }
}
