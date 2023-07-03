import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../const/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLiquidFill(
          waveDuration: const Duration(seconds: 2),
          loadDuration: const Duration(seconds: 6),
          text: 'MUSICA',
          waveColor: Colors.deepPurple,
          boxBackgroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 25.0,
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
