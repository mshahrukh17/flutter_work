// ignore_for_file: file_names, avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:appfood2/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AdminItemController extends GetxController {
  var allitems = [];

  additem(String name) async {
    if (name.isEmpty) {
      message("Error", "Please Enter Item Name");
    } else {
      var key = FirebaseDatabase.instance.ref("items").push().key;
      var itemobj = {
        "name": name,
        "status": true,
        "itemkey": key,
      };
      CollectionReference items =
          FirebaseFirestore.instance.collection("items");
      await items.doc(key).set(itemobj);
      message("Success", "Item Added Successfully");
      getallitemslist();
    }
  }

  getallitemslist() async {
    allitems.clear();
    CollectionReference items = FirebaseFirestore.instance.collection("items");
    await items.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        allitems.add(doc.data());
      });
      update();
    });
  }

  deleteitem(index) {
    CollectionReference items = FirebaseFirestore.instance.collection("items");
    items.doc(allitems[index]["itemkey"]).delete();
    allitems.removeAt(index);
    update();
  }

  updateitem(index, status, name) async {
    if (status == true) {
      CollectionReference items =
          FirebaseFirestore.instance.collection("items");
      await items.doc(allitems[index]["itemkey"]).update({
        "status": !allitems[index]["status"],
      });
      allitems[index]["status"] = !allitems[index]["status"];
    } else {
      CollectionReference updatename =
          FirebaseFirestore.instance.collection("items");
      await updatename.doc(allitems[index]["itemkey"]).update({
        "name": name,
      });
      message("Updated", "Item name Updated");
      getallitemslist();
    }
    update();
  }
}
