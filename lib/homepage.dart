import 'dart:async';
import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double birdWidth = 0.1;
  double birdHeight = 0.1;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  int score = 0;
  int topScore = 0;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
    [0.5, 0.3],
    [0.3, 0.5],
    // [0.6, 0.35],
    // [0.35, 0.6],
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void startGame() {
    if (mounted) {
      gameHasStarted = true;
      Timer.periodic(
        const Duration(milliseconds: 10),
        (timer) {
          height = gravity * time * time + velocity * time;

          setState(() {
            birdY = initialPos - height;
          });

          if (birdIsDead()) {
            timer.cancel();
            _showDialog();
          }
          moveMap();
          time += 0.01;
        },
      );
    }
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.008;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
        setState(() {
          score += 2;
        });
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      score = 0;
      time = 0;
      initialPos = birdY;
      barrierX = [2, 2 + 1.5];
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(
            'GAME  OVER',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          content: Text(
            'Score: $score',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          actions: [
            TextButton(
              child: Text(
                'PLAY  AGAIN',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              onPressed: () {
                if (score > topScore) {
                  topScore = score;
                }
                resetGame();
                // initState();
                // setState(() {
                //   gameHasStarted = false;
                // });
                // startGame();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: gameHasStarted ? jump : startGame,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: Stack(
                      children: [
                        gameHasStarted
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Dark Mode',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                    ),
                                    CupertinoSwitch(
                                      value: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isDarkMode,
                                      onChanged: (value) =>
                                          Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .toggleTheme(),
                                    ),
                                  ],
                                ),
                              ),
                        MyBird(
                          birdY: birdY,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
                        ),
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[2][0],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[2][1],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[3][0],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[3][1],
                          isThisBottomBarrier: true,
                        ),
                        // MyBarrier(
                        //   barrierX: barrierX[0],
                        //   barrierWidth: barrierWidth,
                        //   barrierHeight: barrierHeight[4][0],
                        //   isThisBottomBarrier: true,
                        // ),
                        // MyBarrier(
                        //   barrierX: barrierX[0],
                        //   barrierWidth: barrierWidth,
                        //   barrierHeight: barrierHeight[4][1],
                        //   isThisBottomBarrier: true,
                        // ),
                        // MyBarrier(
                        //   barrierX: barrierX[1],
                        //   barrierWidth: barrierWidth,
                        //   barrierHeight: barrierHeight[5][0],
                        //   isThisBottomBarrier: true,
                        // ),
                        // MyBarrier(
                        //   barrierX: barrierX[1],
                        //   barrierWidth: barrierWidth,
                        //   barrierHeight: barrierHeight[5][1],
                        //   isThisBottomBarrier: true,
                        // ),
                        Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'TAP  TO  PLAY',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 15,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SCORE',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            score.toString(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 35),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BEST',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            topScore.toString(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 35),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
