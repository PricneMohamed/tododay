import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DeletingButton extends StatefulWidget {
  const DeletingButton({super.key, required this.size});

  final Size size;

  @override
  State<DeletingButton> createState() => _DeletingButtonState();
}

class _DeletingButtonState extends State<DeletingButton> {
  @override
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late User? currentUser;

  List tasksId = [];

  Widget build(BuildContext context) {
    currentUser = _auth.currentUser;

    Future<void> getDoneTasks() async {
      try {
        final tasks = await _firestore
            .collection("todolist")
            .doc(currentUser!.uid)
            .get();

        final doneTasks = tasks.data();

        final tasksContainer = doneTasks!['tasks'].where(
          (task) => task['done'] == true,
        );

        print("tasksContainer => $tasksContainer");

        for (var t in tasksContainer) {
          tasksId.indexOf(t['id']) == -1 ? tasksId.add(t['id']) : null;
        }

        if (tasksId.isEmpty)
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'لا توجد مهام منتهية',
            text: '✨ لا يوجد أي مهام مكتملة لحذفها حالياً ',
            confirmBtnText: "طيب",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
          );

        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'متأكد؟ 🗑️',
          text: 'كل المهام اللي أنجزتها هتتمسح نهائي ومش هتقدر ترجعها تاني.',
          confirmBtnText: "امسح",
          onConfirmBtnTap: () async {
            final tasks = await _firestore
                .collection("todolist")
                .doc(currentUser!.uid)
                .get();
            final turesTasks = tasks.data();

            final currentTasks = turesTasks!['tasks'].where(
              (el) => !tasksId.contains(el['id']),
            );
            await _firestore.collection("todolist").doc(currentUser!.uid).set({
              "tasks": currentTasks,
            });
            Navigator.pop(context);
          },
        );
      } on Exception catch (e) {
        print("Error => $e");
        rethrow;
      }
    }

    return Container(
      height: widget.size.width * 0.15,
      width: widget.size.width * 0.15,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: IconButton(
        onPressed: getDoneTasks,
        icon: Icon(Icons.delete, size: 30, color: Colors.white),
      ),
    );
  }
}
