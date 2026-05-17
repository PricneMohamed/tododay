import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Myloading extends StatelessWidget {
  const Myloading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: Colors.teal,
          size: 100,
        ),
      ),
    );
  }
}
