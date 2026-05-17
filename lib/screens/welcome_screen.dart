import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododay/screens/login_screen.dart';
import 'package:tododay/screens/register_screen.dart';
import 'package:tododay/screens/todolisttoday_screen.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/welcome/welcom_body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  static const screenRoute = "/";
  static const screenName = "Welcome";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_auth.currentUser != null) {
        Navigator.of(
          context,
        ).pushReplacementNamed(TodolisttodayScreen.screenRoute);
      }
    });
  }

  final _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(10.0), child: WelcomeBody()),
    );
  }
}
