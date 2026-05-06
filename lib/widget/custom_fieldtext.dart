import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.maxline,
    required this.icon,
    required this.type,
    required this.text,
    required this.state,
    required this.hint,
    required this.obscure,
    required this.onChanged,
  });

  dynamic maxline;
  Icon icon;
  TextInputType type;
  String text;
  bool state;
  String hint;
  bool obscure;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      onChanged: onChanged,
      keyboardType: type,
      obscureText: obscure,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: icon,
        fillColor: state
            ? state
                  ? Colors.blue
                  : Colors.red
            : Colors.red,
        label: Text(
          text,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
        hint: Text("$hint", style: Theme.of(context).textTheme.headlineSmall),
        focusColor: Colors.blue[400],
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: state ? Colors.blue : Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.teal),
        // ),
      ),
    );
  }
}
