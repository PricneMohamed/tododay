  import 'package:flutter/material.dart';

AppBar MyAppBar(BuildContext context, String title, bool arrowBack) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
      ),
      automaticallyImplyLeading: arrowBack,
    );
  }
