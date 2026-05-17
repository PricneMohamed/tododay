import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tododay/servise/method/genText.dart';
import 'package:tododay/servise/models/userProvider.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/main/myloading.dart';
import 'package:uuid/uuid.dart';

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
  bool isLoading = false;

  final _controller = TextEditingController();
  Widget build(BuildContext context) {
    if (isLoading) return Myloading();
    final uuid = Uuid().v4();

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
                  controller: _controller,
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
                      isLoading = true;
                    });
                    if (task.isEmpty) {
                      setState(() {
                        isLoading = false;
                      });
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'استنى شوية 🙂',
                        text: 'اكتب المهمة الأول وبعدين اضغط إضافة',
                        confirmBtnText: "تمام",
                        cancelBtnText: "كنسل",
                      );
                      return;
                    }
                    try {
                      await _firestore
                          .collection("todolist")
                          .doc(widget.userprovider.user.uid)
                          .set({
                            "tasks": FieldValue.arrayUnion([
                              {
                                "id": uuid,
                                "title": task,
                                "createdAt": DateTime.now(),
                                "priority": 0,
                                "done": false,
                              },
                            ]),
                          }, SetOptions(merge: true));
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'تمت إضافة المهمة 🎉',
                        text: getText(),
                        confirmBtnText: "تمام",
                      );
                      task = '';
                    } catch (err, stackTrace) {
                      String message = "فيه مشكلة حصلت ممكن تجرب بعدين 😉";
                      print(err);
                      print(stackTrace);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'استنى شوية 🙂',
                        text: "${err}",
                        confirmBtnText: "تمام",
                      );
                      return;
                    } finally {
                      setState(() {
                        isLoading = false;
                        getText();
                        _controller.clear();
                      });
                    }
                    ;
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
