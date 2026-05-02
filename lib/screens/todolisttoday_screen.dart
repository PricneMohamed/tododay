import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tododay/main.dart';
import 'package:tododay/utils/constant.dart';
import 'package:tododay/widget/home/blockofjob.dart';
import 'package:tododay/widget/main/custom_appbar.dart';
import 'package:tododay/widget/main/myappbar.dart';
import 'package:tododay/widget/main/mydrawer.dart';

class TodolisttodayScreen extends StatefulWidget {
  TodolisttodayScreen({super.key});

  static const screenRoute = "/app";
  static const screenName = "الصفحة الرئيسية";

  @override
  State<TodolisttodayScreen> createState() => _TodolisttodayScreenState();
}

class _TodolisttodayScreenState extends State<TodolisttodayScreen> {
  @override
  final _auth = FirebaseAuth.instance;

  bool isDone = true;
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: Icon(Icons.add, size: 35),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      appBar: MyAppBar(context, "الصفحة الرئيسية", false),
      endDrawer: mydrawer(currentUser: currentUser),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [DeletingButton(size: size)],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Blockofjob(title: "ذاكر JAVA", isDone: isDone),
                      Blockofjob(title: "ذاكر JAVA", isDone: isDone),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeletingButton extends StatelessWidget {
  const DeletingButton({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        width: size.width * 0.2,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[500],
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
          ),
          child: Row(
            spacing: 10,
            children: [Icon(Icons.delete, size: 30, color: Colors.white)],
          ),
        ),
      ),
    );
  }
}
