import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tododay/screens/welcome_screen.dart';
import 'package:tododay/screens/register_screen.dart';
import 'package:tododay/screens/login_screen.dart';
import 'package:tododay/screens/todolisttoday_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme()
            .copyWith(titleLarge: GoogleFonts.tajawal(fontSize: 40))
            .copyWith(
              titleMedium: GoogleFonts.tajawal(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
            .copyWith(
              displayMedium: GoogleFonts.rubik(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
            .copyWith(
              bodyLarge: GoogleFonts.rubik(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
            .copyWith(
              headlineSmall: GoogleFonts.cairo(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )
            .copyWith(
              headlineMedium: GoogleFonts.tajawal(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'ToDo List Today',
      initialRoute: "/",
      routes: {
        "/": (ctx) => WelcomeScreen(),
        RegisterScreen.screenRoute: (ctx) => RegisterScreen(),
        LoginScreen.screenRoute: (ctx) => LoginScreen(),
        TodolisttodayScreen.screenRoute: (ctx) => TodolisttodayScreen(),
      },
    );
  }
}
