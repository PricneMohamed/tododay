import 'package:flutter/material.dart';
import 'package:tododay/screens/profile_screen.dart';
import 'package:tododay/screens/todolisttoday_screen.dart';

const kNmae = "مشواري";

Map<String, dynamic> pages = {
  "home": {
    "name": 'الصفحة الرئيسية',
    "route": TodolisttodayScreen.screenRoute,
    'icon': Icon(Icons.home),
  },
  "profile": {
    "name": 'الملف الشخصي',
    "route": ProfileScreen.screenRoute,
    'icon': Icon(Icons.person),
  },
};
