// ignore_for_file: file_names, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController{
 bool isloading = false;
 
 var ListofUsers = [];

 setloading(value){
  isloading = value;
  update();
 }

 getAllUsers() async {
  setloading(true);
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  await users.get().then((QuerySnapshot snapshot){
    snapshot.docs.forEach((doc){
      ListofUsers.add(doc.data());
    });
  });
  setloading(false);
  update();
 }
}