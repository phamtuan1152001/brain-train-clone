import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget timeBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(right: 300),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "Time",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "0",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}
