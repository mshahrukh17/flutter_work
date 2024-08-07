// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:appfood2/view/Admin/Admindashboard.dart';
import 'package:appfood2/view/Admin/Menu.dart';
import 'package:appfood2/view/Admin/userslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawerdata extends StatefulWidget {
  const drawerdata({super.key});

  @override
  State<drawerdata> createState() => _drawerdataState();
}

class _drawerdataState extends State<drawerdata> {
  var name = "";
  var email = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    email = prefs.getString("email")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  Text(
                    name.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  Text(email.toLowerCase())
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: () {
                Get.off(AdminDashboard());
              },
              child: Card(
                elevation: 5,
                color: Colors.grey.shade300,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(UsersList());
              },
              child: Card(
                elevation: 5,
                color: Colors.grey.shade300,
                child: ListTile(
                  leading: Icon(Icons.person_sharp),
                  title: Text("U S E R S"),
                ),
              ),
            ),
             GestureDetector(
              onTap: () {
                Get.to(Menu());
              },
               child: Card(
                elevation: 5,
                color: Colors.grey.shade300,
                child: ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text("M E N U"),
                ),
                           ),
             ),
            Card(
              elevation: 5,
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("S E T T I N G S"),
              ),
            ),
             Card(
              elevation: 5,
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("L O G O U T"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
