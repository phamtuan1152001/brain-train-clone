import 'package:flutter/material.dart';
import '../../../components/languages/alert.dart';

Future<bool?> displayMyDialog(BuildContext context, bool back) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertComponents(
        questionText: "Bạn có muốn thoát ra ?",
        yesText: "Có",
        noText: "Không",
        flag: back,
      );
    },
  );
}
