// ignore_for_file: prefer_const_constructors

import 'package:appfood2/Controller/AdminController/AdminUserController.dart';
import 'package:appfood2/view/Admin/drawerdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  var adminUserController = Get.put(AdminUserController());

  @override
  void initState() {
    super.initState();
    getallUsers();
  }

  getallUsers() {
    adminUserController.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminUserController>(
      builder: (controller) {
      return Scaffold(
        drawer: drawerdata(),
        appBar: AppBar(
          title: Text("Users List"),
          centerTitle: true,
        ),
        body: Center(
          child: controller.isloading ? CircularProgressIndicator():
          ListView.builder(
            itemCount: controller.ListofUsers.length,
            itemBuilder: (context, index){
              var user = controller.ListofUsers[index];
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Text(user["name"]),
                  subtitle: Text(user["email"]),
                  trailing: Text(user["block"].toString()),
                ),
              );
            }),
        )
      );
    });
  }
}
