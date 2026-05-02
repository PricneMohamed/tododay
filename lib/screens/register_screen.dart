import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tododay/utils/constant.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/main/custom_appbar.dart';
import 'package:tododay/widget/regitser/register_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  static const screenRoute = "/register";
  static const screenName = "نورتنا ";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: SafeArea(child: RegisterBody()),
    );
  }
  }


