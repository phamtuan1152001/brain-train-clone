import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MathPage extends StatefulWidget {
  const MathPage({super.key});

  @override
  State<MathPage> createState() => _MathPage();
}

class _MathPage extends State<MathPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#fffffe"),
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'CHỌN TRÒ CHƠI MathPage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: 25, letterSpacing: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
