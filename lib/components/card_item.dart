import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    required this.image,
    required this.icon,
    required this.title,
    required this.description,
    required this.paddingTop,
    required this.paddingLeft,
    required this.padding,
    required this.color,
  });
  final String image;
  final String icon;
  final String title;
  final String description;
  final double paddingTop;
  final double paddingLeft;
  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: Container(
            alignment: Alignment.bottomCenter,
            width: 250,
            height: 380,
            decoration: BoxDecoration(
                color: HexColor("#eaddcf"),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          icon,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Color(0xff2D2D2D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft, padding, 0, 0),
          child: Image.asset(
            image,
            height: 380,
            width: 240,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
