import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdY;
  final double birdWidth;
  final double birdHeight;

  const MyBird({
    super.key,
    required this.birdY,
    required this.birdWidth,
    required this.birdHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        0,
        (2 * birdY + birdHeight) / (2 - birdHeight),
      ),
      child: Image.asset(
        'lib/images/bird.png',
        width: MediaQuery.of(context).size.height * birdWidth / 1.5,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 1.5,
        fit: BoxFit.fill,
      ),
    );
  }
}
