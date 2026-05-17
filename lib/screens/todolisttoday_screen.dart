import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tododay/servise/models/userProvider.dart';
import 'package:tododay/widget/main/myappbar.dart';
import 'package:tododay/widget/main/mydrawer.dart';
import 'package:tododay/widget/todolist/poppadd.dart';
import 'package:tododay/widget/todolist/todo.dart';

class TodolisttodayScreen extends StatefulWidget {
  TodolisttodayScreen({super.key});

  static const screenRoute = "/app";
  static const screenName = "الصفحة الرئيسية";

  @override
  State<TodolisttodayScreen> createState() => _TodolisttodayScreenState();
}

class _TodolisttodayScreenState extends State<TodolisttodayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool isDone = true;
  List myTasks = [];

  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    Size size = MediaQuery.of(context).size;

    Userprovider userprovider = Provider.of<Userprovider>(context);

    return Scaffold(
      appBar: MyAppBar(context, "الصفحة الرئيسية", false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingBtn(userprovider: userprovider),
      endDrawer: mydrawer(currentUser: currentUser),
      body: ToDo(size: size, firestore: _firestore, auth: _auth),
    );
  }
}

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({super.key, required this.userprovider});

  final Userprovider userprovider;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Center(child: Icon(Icons.add, size: 40, color: Colors.white)),
      backgroundColor: Colors.teal[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(100),
      ),

      elevation: 10,
      autofocus: true,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => PoppAdd(userprovider: userprovider),
        );
      },
    );
  }
}
