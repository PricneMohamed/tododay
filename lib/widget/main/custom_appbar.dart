import 'package:flutter/material.dart';
import 'package:tododay/utils/constant.dart';

AppBar CustomAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      "$kNmae",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 23),
    ),
  );
}
