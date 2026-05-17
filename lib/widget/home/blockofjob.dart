import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tododay/servise/method/genText.dart';

class Blockofjob extends StatefulWidget {
  Blockofjob({
    super.key,
    required this.title,
    required this.isDone,
    required this.id,
  });

  final String title;
  bool isDone;
  String id;

  // final Function

  @override
  State<Blockofjob> createState() => _BlockofjobState();
}

class _BlockofjobState extends State<Blockofjob> {
  @override
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User? currentUser;

  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      currentUser = _auth.currentUser;
    }
    print("${widget.title} ${widget.id}");

    Future<void> currentTask() async {
      try {
        final result = await _firestore
            .collection("todolist")
            .doc(currentUser!.uid)
            .get();

        final currentTask = result.data();

        final res = currentTask!['tasks'].indexWhere(
          (task) => task['id'] == widget.id,
        );

        final itemDone = currentTask!['tasks'][res]['done'] =
            !currentTask!['tasks'][res]['done'];

        print("currentTask => ${currentTask['tasks']}");

        await _firestore.collection("todolist").doc(currentUser!.uid).update({
          "tasks": currentTask['tasks'],
        });

        widget.isDone = itemDone;

        if (!widget.isDone && !itemDone) return;
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: '✅ إنجاز جديد ',
          text: getText(),
          confirmBtnText: "تمام",
          cancelBtnText: "كنسل",
        );
      } on Exception catch (e) {
        throw Exception("err is happened: ${e.toString()}");
      }
    }

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextButton(
        onPressed: currentTask,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
          ),
        ),
        child: ListTile(
          style: ListTileStyle.drawer,
          title: Text(
            "${widget.title}",
            style: GoogleFonts.rubik().copyWith(
              fontSize: 20,
              decoration: widget.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Checkbox(
            value: widget.isDone,
            onChanged: (value) {
              currentTask();
            },
            activeColor: Colors.teal,
          ),
        ),
      ),
    );
  }
}
