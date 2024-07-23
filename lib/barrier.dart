import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierWidth;
  final double barrierHeight;
  final double barrierX;
  final barrierO;
  final bool isThisBottomBarrier;

  const MyBarrier(
      {super.key,
      required this.barrierHeight,
      required this.barrierWidth,
      required this.barrierX,
      this.barrierO,
      required this.isThisBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
