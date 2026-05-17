import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tododay/screens/todolisttoday_screen.dart';
import 'package:tododay/servise/models/userProvider.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/main/myloading.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String email = "";
  bool emailisGood = true;
  String password = "";
  bool passwordisGood = true;
  bool isLoading = false;

  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    Userprovider userprovider = Provider.of<Userprovider>(context);

    if (isLoading) {
      return Myloading();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              "!رجوعك يسعدنا… سجّل دخولك الآن",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          CustomTextField(
            maxline: 1,
            icon: Icon(Icons.email),
            type: TextInputType.emailAddress,
            state: emailisGood,
            text: "Email",
            hint: "prince@example.com",
            obscure: false,
            onChanged: (value) {
              email = value;
            },
          ),
          CustomTextField(
            maxline: 1,
            icon: Icon(Icons.security),
            type: TextInputType.visiblePassword,
            state: passwordisGood,
            text: "Password",
            hint: "***********",
            obscure: true,
            onChanged: (value) {
              password = value;
            },
          ),
          CustomBtn(
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                  if (!email.contains('@') || !email.contains(".")) {
                    emailisGood = false;
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'بريد إلكتروني غير صالح',
                      text: 'تأكد من كتابة البريد الإلكتروني بشكل صحيح.',
                      confirmBtnText: "تمام",
                      cancelBtnText: "كنسل",
                    );
                    return;
                  } else {
                    emailisGood = true;
                  }
                  if (password.length < 6) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      title: 'كلمة المرور ضعيفة',
                      text: 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.',
                      confirmBtnText: "تمام",
                      cancelBtnText: "كنسل",
                    );
                    return;
                  } else {
                    passwordisGood = true;
                  }
                });

                final user = await _auth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                userprovider.user = user.user;

                userprovider.use();

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'مرحبًا 👋',
                  text: 'أهلاً بيك، تم تسجيل الدخول بنجاح 🎉',
                  confirmBtnText: "تمام",
                  cancelBtnText: "كنسل",
                );

                Navigator.of(
                  context,
                ).pushNamed(TodolisttodayScreen.screenRoute);
              } on FirebaseException catch (err) {
                String message = "";

                if (err.code == "wrong-password") {
                  message = "كلمة المرور غير صحيحة ❌";
                } else if (err.code == "invalid-email") {
                  message = "البريد الإلكتروني غير صالح 📧";
                } else if (err.code == "user-disabled") {
                  message = "تم تعطيل هذا الحساب 🚫";
                } else if (err.code == "user-not-found") {
                  message = "المستخدم غير موجود 😓";
                } else {
                  message = "حدث خطأ غير متوقع، حاول مرة أخرى ⚠️";
                }

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Oops...',
                  text: message,
                  confirmBtnText: "تمام",
                  cancelBtnText: "كنسل",
                );
                return;
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
            color: Colors.teal,
            text: "سجل دخول",
            textColor: Colors.white,
            icon: Icon(Icons.login, size: 30),
          ),
        ],
      ),
    );
  }
}
