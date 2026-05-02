import 'package:flutter/material.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/login/login_body.dart';
import 'package:tododay/widget/main/custom_appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  static const screenRoute = "/login";
  static const screenName = "نورتنا من تاني";

  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(context), body: LoginBody());
  }
}
