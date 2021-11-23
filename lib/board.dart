import 'dart:math';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/material.dart';
import 'package:game2048/node.dart';

class Board extends StatefulWidget {
  final Function(int) updateScore;
  final Function() saveHighestScore;
  final Function() setScoreToZero;
  const Board({
    Key? key,
    required this.updateScore,
    required this.saveHighestScore,
    required this.setScoreToZero,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Node n0 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n1 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n2 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n3 = Node(0, null, null, null, null, CommonData.elementWidth);

  Node n4 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n5 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n6 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n7 = Node(0, null, null, null, null, CommonData.elementWidth);

  Node n8 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n9 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n10 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n11 = Node(0, null, null, null, null, CommonData.elementWidth);

  Node n12 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n13 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n14 = Node(0, null, null, null, null, CommonData.elementWidth);
  Node n15 = Node(0, null, null, null, null, CommonData.elementWidth);

  List<Node> nodesForVerticalMovement = [];
  List<Node> nodesForhorizontalMovement = [];
  List<int> baseValues = [2, 2, 2, 2, 4, 4, 4, 8, 8, 16];

  generateGameMatrix() {
    setState(() {
      n0 = Node(0, null, null, null, null, CommonData.elementWidth);
      n1 = Node(0, null, null, null, null, CommonData.elementWidth);
      n2 = Node(0, null, null, null, null, CommonData.elementWidth);
      n3 = Node(0, null, null, null, null, CommonData.elementWidth);

      n4 = Node(0, null, null, null, null, CommonData.elementWidth);
      n5 = Node(0, null, null, null, null, CommonData.elementWidth);
      n6 = Node(0, null, null, null, null, CommonData.elementWidth);
      n7 = Node(0, null, null, null, null, CommonData.elementWidth);
      n8 = Node(0, null, null, null, null, CommonData.elementWidth);
      n9 = Node(0, null, null, null, null, CommonData.elementWidth);
      n10 = Node(0, null, null, null, null, CommonData.elementWidth);
      n11 = Node(0, null, null, null, null, CommonData.elementWidth);

      n12 = Node(0, null, null, null, null, CommonData.elementWidth);
      n13 = Node(0, null, null, null, null, CommonData.elementWidth);
      n14 = Node(0, null, null, null, null, CommonData.elementWidth);
      n15 = Node(0, null, null, null, null, CommonData.elementWidth);
      nodesForVerticalMovement = [
        n0,
        n1,
        n2,
        n3,
        n4,
        n5,
        n6,
        n7,
        n8,
        n9,
        n10,
        n11,
        n12,
        n13,
        n14,
        n15
      ];

      nodesForhorizontalMovement = [
        n0,
        n4,
        n8,
        n12,
        n1,
        n5,
        n9,
        n13,
        n2,
        n6,
        n10,
        n14,
        n3,
        n7,
        n11,
        n15
      ];

      n0.right = n1;
      n0.down = n4;

      n1.left = n0;
      n1.down = n5;
      n1.right = n2;

      n2.left = n1;
      n2.down = n6;
      n2.right = n3;

      n3.left = n2;
      n3.down = n7;

      n4.up = n0;
      n4.down = n8;
      n4.right = n5;

      n5.up = n1;
      n5.left = n4;
      n5.down = n9;
      n5.right = n6;

      n6.up = n2;
      n6.left = n5;
      n6.down = n10;
      n6.right = n7;

      n7.up = n3;
      n7.left = n6;
      n7.down = n11;

      n8.up = n4;
      n8.down = n12;
      n8.right = n9;

      n9.up = n5;
      n9.left = n8;
      n9.down = n13;
      n9.right = n10;

      n10.up = n6;
      n10.left = n9;
      n10.down = n14;
      n10.right = n11;

      n11.up = n7;
      n11.left = n10;
      n11.down = n15;

      n12.up = n8;
      n12.right = n13;

      n13.up = n9;
      n13.left = n12;
      n13.right = n14;

      n14.up = n10;
      n14.left = n13;
      n14.right = n15;

      n15.up = n11;
      n15.left = n14;

      nodesForVerticalMovement[Random().nextInt(15)].value = 2;
    });
  }

  @override
  void initState() {
    generateGameMatrix();
    super.initState();
  }

  void moveUp(Node currNode) {
    setState(() {
      if (currNode.up != null) {
        if (currNode.up!.value == 0 && currNode.value != 0) {
          currNode.up!.value = currNode.value;
          currNode.value = 0;
          moveUp(currNode.up!);
        }
        if (currNode.up!.value == currNode.value &&
            currNode.value != 0 &&
            currNode.up!.alreadyCombined == false) {
          currNode.up!.value += currNode.value;
          currNode.value = 0;
          currNode.up!.alreadyCombined = true;
          widget.updateScore(currNode.up!.value);
        }
      }
    });
  }

  void moveDown(Node currNode) {
    setState(() {
      if (currNode.down != null) {
        if (currNode.down!.value == 0 && currNode.value != 0) {
          currNode.down!.value = currNode.value;
          currNode.value = 0;
          moveDown(currNode.down!);
        }
        if (currNode.down!.value == currNode.value &&
            currNode.value != 0 &&
            currNode.down!.alreadyCombined == false) {
          currNode.down!.value += currNode.value;
          currNode.value = 0;
          currNode.down!.alreadyCombined = true;
          widget.updateScore(currNode.down!.value);
        }
      }
    });
  }

  void moveLeft(Node currNode) {
    setState(() {
      if (currNode.left != null) {
        if (currNode.left!.value == 0 && currNode.value != 0) {
          currNode.left!.value = currNode.value;
          currNode.value = 0;
          moveLeft(currNode.left!);
        }
        if (currNode.left!.value == currNode.value &&
            currNode.value != 0 &&
            currNode.left!.alreadyCombined == false) {
          currNode.left!.value += currNode.value;
          currNode.value = 0;
          currNode.left!.alreadyCombined = true;
          widget.updateScore(currNode.left!.value);
        }
      }
    });
  }

  void moveRight(Node currNode) {
    setState(() {
      if (currNode.right != null) {
        if (currNode.right!.value == 0 && currNode.value != 0) {
          currNode.right!.value = currNode.value;
          currNode.value = 0;
          moveRight(currNode.right!);
        }
        if (currNode.right!.value == currNode.value &&
            currNode.value != 0 &&
            currNode.right!.alreadyCombined == false) {
          currNode.right!.value += currNode.value;
          currNode.value = 0;
          currNode.right!.alreadyCombined = true;
          widget.updateScore(currNode.right!.value);
        }
      }
    });
  }

  void checkGameState() {
    bool endGameCheck1 = true;
    bool endGameCheck2 = true;

    for (Node node in nodesForVerticalMovement) {
      if (node.down != null) {
        if (node.down!.value == node.value) {
          endGameCheck1 = false;
          break;
        }
      }
    }

    for (Node node in nodesForhorizontalMovement) {
      if (node.right != null) {
        if (node.right!.value == node.value) {
          endGameCheck2 = false;
          break;
        }
      }
    }
    if (endGameCheck1 && endGameCheck2) {
      widget.saveHighestScore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4e7),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (CommonData.isSoundOn) {
                  Audio.load('assets/sounds/retrogameclick.wav')
                    ..play()
                    ..dispose();
                }

                if (details.primaryVelocity! > 0) {
                  for (Node node in nodesForVerticalMovement) {
                    node.alreadyCombined = false;
                  }
                  for (Node node in nodesForVerticalMovement.reversed) {
                    moveDown(node);
                  }
                  List<Node> freeNodes = [];
                  for (Node node in nodesForVerticalMovement) {
                    if (node.value == 0) {
                      freeNodes.add(node);
                    }
                  }
                  if (freeNodes.isEmpty) {
                    checkGameState();
                  } else {
                    freeNodes[Random().nextInt(freeNodes.length)].value =
                        baseValues[Random().nextInt(baseValues.length)];
                  }
                } else {
                  for (Node node in nodesForVerticalMovement) {
                    node.alreadyCombined = false;
                  }
                  for (Node node in nodesForVerticalMovement) {
                    moveUp(node);
                  }
                  List<Node> freeNodes = [];
                  for (Node node in nodesForVerticalMovement) {
                    if (node.value == 0) {
                      freeNodes.add(node);
                    }
                  }
                  if (freeNodes.isEmpty) {
                    checkGameState();
                  } else {
                    freeNodes[Random().nextInt(freeNodes.length)].value =
                        baseValues[Random().nextInt(baseValues.length)];
                  }
                }
              },
              onHorizontalDragEnd: (details) {
                if (CommonData.isSoundOn) {
                  Audio.load('assets/sounds/retrogameclick.wav')
                    ..play()
                    ..dispose();
                }

                if (details.primaryVelocity! > 0) {
                  for (Node node in nodesForVerticalMovement) {
                    node.alreadyCombined = false;
                  }
                  for (Node node in nodesForhorizontalMovement.reversed) {
                    moveRight(node);
                  }
                  List<Node> freeNodes = [];
                  for (Node node in nodesForVerticalMovement) {
                    if (node.value == 0) {
                      freeNodes.add(node);
                    }
                  }
                  if (freeNodes.isEmpty) {
                    checkGameState();
                  } else {
                    freeNodes[Random().nextInt(freeNodes.length)].value =
                        baseValues[Random().nextInt(baseValues.length)];
                  }
                } else {
                  for (Node node in nodesForVerticalMovement) {
                    node.alreadyCombined = false;
                  }
                  for (Node node in nodesForhorizontalMovement) {
                    moveLeft(node);
                  }
                  List<Node> freeNodes = [];
                  for (Node node in nodesForVerticalMovement) {
                    if (node.value == 0) {
                      freeNodes.add(node);
                    }
                  }
                  if (freeNodes.isEmpty) {
                    checkGameState();
                  } else {
                    freeNodes[Random().nextInt(freeNodes.length)].value =
                        baseValues[Random().nextInt(baseValues.length)];
                  }
                }
              },
              child: Container(
                height: CommonData.frameWidth,
                width: CommonData.frameWidth,
                decoration: BoxDecoration(
                  color: const Color(0xff9c948c),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        n0.project,
                        n1.project,
                        n2.project,
                        n3.project,
                      ],
                    ),
                    Row(
                      children: [
                        n4.project,
                        n5.project,
                        n6.project,
                        n7.project,
                      ],
                    ),
                    Row(
                      children: [
                        n8.project,
                        n9.project,
                        n10.project,
                        n11.project,
                      ],
                    ),
                    Row(
                      children: [
                        n12.project,
                        n13.project,
                        n14.project,
                        n15.project,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (CommonData.isSoundOn) {
                      Audio.load('assets/sounds/retrogameclick.wav')
                        ..play()
                        ..dispose();
                    }
                    generateGameMatrix();
                    widget.setScoreToZero();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffbbad9f),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Restart',
                        style: TextStyle(
                          color: Color(0xfff7f4e7),
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
