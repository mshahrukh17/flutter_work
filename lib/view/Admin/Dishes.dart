// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';

import 'package:appfood2/Controller/AdminController/AdminDishController.dart';
import 'package:appfood2/view/Admin/drawerdata.dart';
import 'package:appfood2/widgets/TextFied.dart';
import 'package:appfood2/widgets/mybutton2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  var admindishcontroller = Get.put(AdminDishController());
  @override
  void initState() {
    super.initState();
    getdishes();
  }

  getdishes() {
    admindishcontroller.getalldishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: drawerdata(),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Dishes"),
        ),
        body: GetBuilder<AdminDishController>(
          builder: (controller) {
            return controller.isloading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                        height: 80.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                                radius: 30,
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.black,
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectimage(
                                                    ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  child: Icon(
                                                    Icons.photo,
                                                    color: Colors.black,
                                                  )),
                                            )
                                          ],
                                        ));
                                  });
                            },
                            child: controller.image == null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.black,
                                    ))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        FileImage(controller.image),
                                  )),
                      ),
                      TextFieldWidget2(
                          prefixicon: Icon(Icons.restaurant),
                          hinttext: "Item name",
                          width: MediaQuery.of(context).size.width * 0.7,
                          controller: controller.namecontroller),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFieldWidget2(
                              prefixicon: Icon(Icons.monetization_on),
                              hinttext: "Item Price",
                              width: MediaQuery.of(context).size.width * 0.4,
                              controller: controller.pricecontroller),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: controller.dropdownvalue == ""
                                      ? Text('Select Category')
                                      : Text(
                                          controller.dropdownvalue.toString()),
                                  // value: controller.dropdownvalue,
                                  onChanged: (newValue) {
                                    newValue as Map;
                                    controller.setdropdown(newValue);
                                  },
                                  items: controller.alldish.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item["name"]),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Mybutton2(
                        onpress: () {
                          controller.adddishes();
                        },
                        buttontext: "Add Item",
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.transparent,
                        height: 80,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.alldish.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Mybutton2(
                                  onpress: () {},
                                  buttontext: controller.alldish[index]["name"]
                                      .toString()
                                      .toUpperCase(),
                                ),
                              );
                            }),
                      )
                    ],
                  );
          },
        ));
  }
}
