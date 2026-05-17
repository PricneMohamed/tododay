import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tododay/utils/constant.dart';

class mydrawer extends StatelessWidget {
  const mydrawer({super.key, required this.currentUser});

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(100),
              child: Image.asset("images/avatar.jpg", fit: BoxFit.cover),
            ),
            accountName: Text("Mohamed"),
            accountEmail: Text("${currentUser?.email}"),
          ),
          ...pages.entries.map((value) {
            return ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(value.value['route']);
              },
              title: Text(
                value.value['name'],
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              leading: value.value['icon'],
            );
          }).toList(),
        ],
      ),
    );
  }
}
