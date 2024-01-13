import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget gameBoard(String titel, String info) {
  return Scaffold(
      backgroundColor: Color(0xFFe55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              titel,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              info,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ));
}
