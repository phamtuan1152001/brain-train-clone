import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AttentionPage extends StatefulWidget {
  const AttentionPage({super.key});

  @override
  State<AttentionPage> createState() => _AttentionPage();
}

class _AttentionPage extends State<AttentionPage> {
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
                  'CHỌN TRÒ CHƠI AttentionPage',
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
