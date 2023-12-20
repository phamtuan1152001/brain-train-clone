import 'package:flutter/material.dart';

class AlertComponents extends StatefulWidget {
  const AlertComponents({
    Key? key,
    required this.questionText,
    required this.yesText,
    required this.noText,
    required this.flag,
  }) : super(key: key);

  final String questionText;
  final String yesText;
  final String noText;
  final bool flag;

  @override
  _AlertComponentsState createState() => _AlertComponentsState();
}

class _AlertComponentsState extends State<AlertComponents> {
  late bool _flag;

  @override
  void initState() {
    super.initState();
    _flag = widget.flag;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.questionText),
      actions: [
        TextButton(
          child: Text(widget.noText),
          onPressed: () {
            setState(() {
              _flag = false;
            });
            Navigator.pop(context, _flag);
          },
        ),
        TextButton(
          child: Text(widget.yesText),
          onPressed: () {
            setState(() {
              _flag = true;
            });
            Navigator.pop(context, _flag);
          },
        ),
      ],
    );
  }
}
