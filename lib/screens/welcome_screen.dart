import 'package:flutter/material.dart';
import 'package:tododay/screens/login_screen.dart';
import 'package:tododay/screens/register_screen.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/welcome/welcom_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  static const screenRoute = "/";
  static const screenName = "Welcome";

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(10.0), child: WelcomeBody()),
    );
  }
}
