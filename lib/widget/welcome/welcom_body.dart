import 'package:flutter/material.dart';
import 'package:tododay/screens/login_screen.dart';
import 'package:tododay/screens/register_screen.dart';
import 'package:tododay/widget/custom_btn.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset("images/logo.png"),
        CustomBtn(
          onPressed: () {
            Navigator.of(context).pushNamed(RegisterScreen.screenRoute);
          },
          color: Colors.teal,
          text: RegisterScreen.screenName,
          textColor: Colors.white,
          icon: Icon(Icons.run_circle, size: 30),
        ),
        CustomBtn(
          onPressed: () {
            Navigator.of(context).pushNamed(LoginScreen.screenRoute);
          },
          color: Colors.white70,
          text: LoginScreen.screenName,
          textColor: Colors.black87,
          icon: Icon(Icons.run_circle, size: 30),
        ),
      ],
    );
  }
}
