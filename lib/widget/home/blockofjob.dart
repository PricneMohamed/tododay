import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Blockofjob extends StatefulWidget {
  Blockofjob({super.key, required this.title, required this.isDone});

  final String title;
  bool isDone;

  @override
  State<Blockofjob> createState() => _BlockofjobState();
}

class _BlockofjobState extends State<Blockofjob> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            widget.isDone = !widget.isDone;
          });
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
          ),
        ),
        child: ListTile(
          style: ListTileStyle.drawer,
          title: Text(
            "${widget.title}",
            style: GoogleFonts.rubik().copyWith(
              fontSize: 20,
              decoration: widget.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Checkbox(
            value: widget.isDone,
            onChanged: (value) {
              setState(() {
                widget.isDone = !widget.isDone;
              });
            },
            activeColor: Colors.teal,
          ),
        ),
      ),
    );
  }
}
