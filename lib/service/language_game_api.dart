// import 'package:flutter/services.dart';
// import 'dart:math';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brain_train_clone_app/constants/mock_data.dart';

final validlanguagesUrl = MockData().validlanguagesUrl;

Future<bool> checkValidWord(String value) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  final response = await http.post(Uri.parse("$validlanguagesUrl"),
      headers: headers, body: jsonEncode({"text": value}));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> checkMatchWord(controllerInput, firstLetter) async {
  String userAnswer = controllerInput;
  for (int i = 0; i < firstLetter.length; i++) {
    if ("$userAnswer" == firstLetter[i]) {
      return false;
    }
  }
  return true;
}

// Future<void> fetchRandomCharacter(listLetter, currentIndex, VoidCallback setState) async {
//   final String response = await rootBundle.loadString(listLetter);
//   final data = await json.decode(response);
//   currentIndex = Random().nextInt(data["letter"].length);
//   setState(() {
//     String firstCharacter = data["letter"][currentIndex].split(' ')[0];
//     _firstLetter.add(firstCharacter);
//     firstLetter = _firstLetter[1];
//     letterList = data["letter"];
//   });
// }
