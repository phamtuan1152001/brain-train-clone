import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(26),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          // Bảng trắng nhỏ 2 bên
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              info,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
    ),
  );
}
