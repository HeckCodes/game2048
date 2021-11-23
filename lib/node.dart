import 'package:flutter/material.dart';

class Node {
  int value = 0;
  double innerBoxDimention;
  bool? alreadyCombined;
  Node? left;
  Node? right;
  Node? up;
  Node? down;

  Node(
    this.value,
    this.left,
    this.right,
    this.up,
    this.down,
    this.innerBoxDimention,
  );

  Widget get project {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Container(
        child: Center(
          child: Text(
            value == 0 ? '' : value.toString(),
            style: TextStyle(
              color: const Color(0xff3c3a32),
              fontSize: (value > 999) ? 16 : 24,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        height: innerBoxDimention,
        width: innerBoxDimention,
        decoration: BoxDecoration(
          color: nodeColor(value),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color? nodeColor(int value) {
    switch (value) {
      case 2:
        return const Color(0xffeee3dd);
      case 4:
        return const Color(0xffefdfc5);
      case 8:
        return const Color(0xffefb27b);
      case 16:
        return const Color(0xfff79663);
      case 32:
        return const Color(0xfff79000);
      case 64:
        return const Color(0xfff75d3b);
      case 128:
        return const Color(0xffedce71);
      case 256:
        return const Color(0xffeec652);
      case 512:
        return const Color(0xffefc652);
      case 1024:
        return const Color(0xffedc231);
      case 2048:
        return const Color(0xffefc233);
      case 4096:
        return const Color(0xff6cc90d);
      case 8192:
        return const Color(0xff4a8a10);
      default:
        return const Color(0xffd6cdc4);
    }
  }
}

class CommonData {
  static double elementWidth = 0;
  static double frameWidth = 0;
  static bool isSoundOn = true;
}
