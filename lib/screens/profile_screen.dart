import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/main/myappbar.dart';
import 'package:tododay/widget/main/mydrawer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  static const screenRoute = "/profile";
  static const screenName = "الملف الشخصي";

  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    User? currentUser;

    if (_auth.currentUser != null) {
      currentUser = _auth.currentUser;
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(context, screenName, true),
      endDrawer: mydrawer(currentUser: currentUser),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                child: Image.asset(
                  "images/avatar.jpg",
                  width: size.width * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text("${currentUser!.email}"),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextField(
                maxline: null,
                icon: Icon(Icons.mail),
                type: TextInputType.emailAddress,
                text: "Email",
                state: false,
                hint: "ادخل بريدك الالكتروني",
                obscure: false,
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextField(
                maxline: null,
                icon: Icon(Icons.security),
                type: TextInputType.visiblePassword,
                text: "Password",
                state: false,
                hint: "ادخل كلمة السر الجديدة",
                obscure: false,
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomBtn(
                onPressed: () {},
                color: Colors.teal,
                text: "حفظ",
                textColor: Colors.white,
                icon: Icon(Icons.save, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
