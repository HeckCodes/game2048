import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game2048/board.dart';
import 'package:game2048/node.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audiofileplayer/audiofileplayer.dart';

void main() {
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "2048",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'PressStart2P'),
      home: const MainGameScreen(),
    );
  }
}

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainGameScreenState createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  int score = 0;
  int highestScore = 0;

  updateScore(int newScore) {
    if (CommonData.isSoundOn) {
      Audio.load('assets/sounds/gameclick.wav')
        ..play()
        ..dispose();
    }

    setState(() {
      score += newScore;
      if (score > highestScore) {
        highestScore = score;
      }
    });
  }

  setScoreToZero() {
    setState(() {
      score = 0;
    });
  }

  saveHighestScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('highestScore', highestScore);
  }

  getScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('score') ?? 0;
      highestScore = prefs.getInt('highestScore') ?? 0;
    });
  }

  @override
  void initState() {
    getScores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonData.frameWidth = MediaQuery.of(context).size.width - 24;
    CommonData.elementWidth = CommonData.frameWidth / 4 - 10;

    return Scaffold(
      backgroundColor: const Color(0xfff7f4e7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '2048',
                    style: TextStyle(
                      color: Color(0xff766c63),
                      fontSize: 36,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffbbad9f),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          CommonData.isSoundOn = !CommonData.isSoundOn;
                        });
                      },
                      icon: CommonData.isSoundOn
                          ? const Icon(Icons.volume_up_rounded)
                          : const Icon(Icons.volume_off_rounded),
                      color: const Color(0xfff7f4e7),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffbbad9f),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            ' SCORE ',
                            style: TextStyle(
                              color: Color(0xfff7f4e7),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            score.toString(),
                            style: const TextStyle(
                              color: Color(0xfff7f4e7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffbbad9f),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'HIGHEST',
                            style: TextStyle(
                              color: Color(0xfff7f4e7),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            highestScore.toString(),
                            style: const TextStyle(
                              color: Color(0xfff7f4e7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Board(
                  updateScore: updateScore,
                  saveHighestScore: saveHighestScore,
                  setScoreToZero: setScoreToZero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
