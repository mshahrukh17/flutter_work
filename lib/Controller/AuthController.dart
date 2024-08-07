// ignore_for_file: file_names, unused_local_variable, non_constant_identifier_names, prefer_const_constructors, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/message.dart';

class AuthController extends GetxController {
  bool isloading = false;

  setloading(value) {
    isloading = value;
    update();
  }

  

  signupuser(email, password, name) async {
    try {
      setloading(true);
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // object of users data
      var obj = {
        "name" : name,
        "email" : email,
        "password" : password,
        "type" : "user",
        "block" : false
      };
      // collection of firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      await users.doc(userCredential.user!.uid).set(obj);
      // user! user id
      var uid = userCredential.user!.uid;
      setloading(false);
      message("Success", "Account Created successfully");
    } catch (e) {
      setloading(false);
      message("error", e.toString());
    }
  }

  setPrefernce(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Login", true);
    prefs.setString("usertype", data["type"]);
    prefs.setString("name", data["name"]);
    prefs.setString("email", data["email"]);
  }

  loginuser(email, password) async {
    try {
      setloading(true);
      final UserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseFirestore.instance
          .collection("users")
          .doc(UserCredential.user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map;
          print("User data: ${data["type"]}");
          if (data["block"]==true) {
            message("Block", "Contact to Admin");
          }
        } else {
          FirebaseFirestore.instance
              .collection("admin")
              .doc(UserCredential.user!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              var data = documentSnapshot.data() as Map;
              print("Admin data: ${data["type"]}");
              setPrefernce(data);
              // Get.offAll(AdminDashboard());
            } else {
              print("Document does not exist on the database");
            }
          });
        }
      });

      var uid = UserCredential.user!.uid;
      setloading(false);
      message("Success", "User Login successfully");
    } catch (e) {
      setloading(false);
      message("error", e.toString());
    }
  }
}
