import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  CustomBtn({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
    required this.textColor,
    required this.icon,
  });

  final VoidCallback onPressed;
  Color color;
  String text;
  Color textColor;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [Text("${text}"), icon],
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        elevation: 10.0,
        backgroundColor: color,
        textStyle: Theme.of(
          context,
        ).textTheme.displayMedium!.copyWith(color: Colors.white),
        foregroundColor: textColor,
      ),
    );
  }
}
