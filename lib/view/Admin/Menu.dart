// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:appfood2/Controller/AdminController/AdminItemController.dart';
import 'package:appfood2/view/Admin/drawerdata.dart';
import 'package:appfood2/widgets/TextFied.dart';
import 'package:appfood2/widgets/mybutton.dart';
import 'package:appfood2/widgets/mybutton2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var adminitemcontroller = Get.put(AdminItemController());
  final ItemController = TextEditingController();
  final updateitem = TextEditingController();
  var selectedindex;
  @override
  void initState() {
    super.initState();
    viewitemlist();
    ItemController.clear();
  }

  viewitemlist() {
    adminitemcontroller.getallitemslist();
    ItemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: drawerdata(),
      ),
      body: GetBuilder<AdminItemController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget2(
                  controller: ItemController,
                  hinttext: "Add Item",
                  prefixicon: Icon(Icons.restaurant),
                ),
                SizedBox(
                  height: 10,
                ),
                Mybutton(
                  onpress: () {
                    controller.additem(ItemController.text);
                    ItemController.clear();
                  },
                  buttontext: "Add Item",
                ),
                SizedBox(
                  height: 25.0,
                ),
                controller.allitems.isEmpty
                    ? Text("No Items")
                    : DataTable(
                        columnSpacing: 40.0,
                        border: TableBorder(
                            right: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            verticalInside: BorderSide(color: Colors.black),
                            horizontalInside: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(
                              color: Colors.black,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                            )),
                        columns: [
                          DataColumn(
                              label: Text(
                            "S.No",
                            style: TextStyle(
                                fontFamily: "font1",
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          )),
                          DataColumn(
                              label: Text("Name",
                                  style: TextStyle(
                                      fontFamily: "font1",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                          DataColumn(
                              label: Text("  Status",
                                  style: TextStyle(
                                      fontFamily: "font1",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                          DataColumn(
                              label: Text("Action",
                                  style: TextStyle(
                                      fontFamily: "font1",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                        ],
                        rows:
                            List.generate(controller.allitems.length, (index) {
                          var items = controller.allitems[index];
                          return DataRow(cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(items["name"])),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.updateitem(index, true, "");
                                    },
                                    icon: Icon(items["status"] == true
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box)),
                                Text(items["status"].toString()),
                              ],
                            )),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.deleteitem(index);
                                    },
                                    child: Icon(Icons.delete)),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedindex = index;
                                        updateitem.text = items["name"];
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text("Update"),
                                            content: TextFieldWidget2(
                                              controller: updateitem,
                                            ),
                                            elevation: 10.0,
                                            actions: [
                                              Mybutton2(
                                                onpress: () {
                                                  Navigator.pop(context);
                                                },
                                                buttontext: "Cancel",
                                              ),
                                              Mybutton2(
                                                onpress: () {
                                                  controller.updateitem(index,
                                                      false, updateitem.text);
                                                  Navigator.pop(context);
                                                },
                                                buttontext: "Update",
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ))
                          ]);
                        }))
              ],
            ),
          );
        },
      ),
    );
  }
}
