// ignore_for_file: prefer_const_constructors, file_names

import 'package:appfood2/view/Admin/drawerdata.dart';
import 'package:flutter/material.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
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
    );
  }
}