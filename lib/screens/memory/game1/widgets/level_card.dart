import 'dart:math';
import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({
    Key? key,
    required this.level,
    // required this.starts,
    required this.isOpen,
    required this.onPressed,
  }) : super(key: key);

  final int level;
  // final int starts;
  final bool isOpen;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.red,
      Colors.redAccent,
      Colors.purple,
      Colors.blueAccent,
      Colors.amber,
      Colors.blue
    ];
    final random = Random().nextInt(6);

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Star(top: 22, isFull: stars > 0, isOpen: isOpen),
          //     // Star(isFull: stars > 1, isOpen: isOpen),
          //     // Star(top: 22, isFull: stars > 2, isOpen: isOpen),
          //   ],
          // ),
          InkWell(
            onTap: isOpen ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 37, bottom: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      colors[random].withOpacity(isOpen ? .9 : .2),
                      BlendMode.modulate,
                    ),
                    child: Image.asset("assets/level.png"),
                  ),
                  Text(
                    'Level \n$level',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(isOpen ? 1 : .2),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (!isOpen)
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Icon(
                Icons.lock,
                size: 40,
                color: Colors.amber,
              ),
            )
        ],
      ),
    );
  }
}
