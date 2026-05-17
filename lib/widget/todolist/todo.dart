import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododay/widget/home/blockofjob.dart';

import 'package:tododay/widget/main/myloading.dart';
import 'package:tododay/widget/todolist/deleting_btn.dart';

import 'package:intl/intl.dart';

class ToDo extends StatelessWidget {
  ToDo({
    super.key,
    required this.size,
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  final Size size;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  final date = new DateFormat();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text("${DateFormat.yMMMd().format(DateTime.now())}"),
                ),
                DeletingButton(size: size),
              ],
            ),
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
                    child: StreamBuilder(
                      stream: _firestore
                          .collection("todolist")
                          .doc(_auth.currentUser?.uid)
                          .snapshots(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting)
                          return Myloading();
                        if (asyncSnapshot.hasData == null ||
                            !asyncSnapshot.data!.exists ||
                            asyncSnapshot.data!.data() == null ||
                            asyncSnapshot.data!.data()!['tasks'].isEmpty)
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "✨لا توجد مهام حالياً ",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "💙 ابدأ بخطوة صغيرة اليوم، إنجازاتك تستحق ",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          );
                        final data =
                            asyncSnapshot.data!.data() as Map<String, dynamic>;
                        return ListView(
                          children: (data['tasks'] ?? [])
                              ?.map<Widget>(
                                (tas) => Blockofjob(
                                  id: tas["id"],
                                  title: tas['title'],
                                  isDone: tas['done'],
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
