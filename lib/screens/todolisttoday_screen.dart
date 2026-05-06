import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tododay/main.dart';
import 'package:tododay/servise/models/userProvider.dart';
import 'package:tododay/utils/constant.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
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
  void initState() {
    super.initState();
    getMyTasks();
  }

  @override
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool isDone = true;
  List myTasks = [];

  void getMyTasks() async {
    final currentUser = _auth.currentUser;
    print("currentUser ===>${currentUser?.uid}");
    try {
      if (currentUser == null) {
        print("user is define");
        return;
      }
      final t = await _firestore
          .collection("todolist")
          .doc(_auth.currentUser?.uid)
          .collection("tasks")
          .get();

      for (var task in t.docs) {
        print("loading...");
        print("data ========> ${task.data()}");
      }
    } on Exception catch (err) {
      throw Exception(err);
    }
  }

  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    Size size = MediaQuery.of(context).size;

    Userprovider userprovider = Provider.of<Userprovider>(context);

    return Scaffold(
      appBar: MyAppBar(context, "الصفحة الرئيسية", false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
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
      ),
      endDrawer: mydrawer(currentUser: currentUser),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [DeletingButton(size: size)],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.73,
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
                      child: ListView(children: []),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeletingButton extends StatefulWidget {
  const DeletingButton({super.key, required this.size});

  final Size size;

  @override
  State<DeletingButton> createState() => _DeletingButtonState();
}

class _DeletingButtonState extends State<DeletingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.width * 0.15,
      width: widget.size.width * 0.15,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete, size: 30, color: Colors.white),
      ),
    );
  }
}

class PoppAdd extends StatefulWidget {
  PoppAdd({super.key, required this.userprovider});

  Userprovider userprovider;
  @override
  State<PoppAdd> createState() => _PoppAddState();
}

class _PoppAddState extends State<PoppAdd> {
  @override
  String task = "";
  bool isGood = true;
  final _firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                CustomTextField(
                  maxline: null,
                  icon: Icon(Icons.text_fields, size: 30),
                  type: TextInputType.text,
                  text: "ضيف تاسكك",
                  state: isGood,
                  hint: "مضيعش نفسك في حاجة مش مفيدة حط هدف لنفسك",
                  obscure: false,
                  onChanged: (value) {
                    task = value;
                  },
                ),
                CustomBtn(
                  onPressed: () async {
                    setState(() {
                      if (task.isEmpty) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'استنى شوية 🙂',
                          text: 'اكتب المهمة الأول وبعدين اضغط إضافة',
                        );
                        return;
                      }
                      try {
                        _firestore
                            .collection("todolist")
                            .doc(widget.userprovider.user.uid)
                            .set(
                              
                              {"tasks":{
                              "createdAt": FieldValue.serverTimestamp(),
                              "title": task,
                              "priority": 0,
                              "done": false,
                            }});
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'تمت إضافة المهمة 🎉',
                          text: 'استمر في الإنجاز… وقتك هو أغلى ما تملك',
                        );
                      } catch (err) {
                        String message = "فيه مشكلة حصلت ممكن تجرب بعدين 😉";

                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'استنى شوية 🙂',
                          text: "${message}",
                        );
                        return;
                      }
                    });
                  },
                  color: Colors.teal,
                  text: "اضف التاسك",
                  textColor: Colors.white,
                  icon: Icon(Icons.note, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
