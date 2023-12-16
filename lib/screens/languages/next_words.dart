import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:brain_train_clone_app/components/card_item.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';

class NextWordsPage extends StatefulWidget {
  const NextWordsPage({super.key});

  @override
  State<NextWordsPage> createState() => _NextWordsPage();
}

class _NextWordsPage extends State<NextWordsPage> {
  @override
  Widget build(BuildContext context) {
    final languageGames = MockData.languageGames;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#fffffe"),
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //       Colors.white,
          //       Color(0xE6FFCD4D),
          //     ])),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'Selecting A next words Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: HexColor("#020826"),
                      fontSize: 25,
                      letterSpacing: 1),
                ),
              ),
              // size box test
            ],
          ),
        ),
      ),
    );
  }
}
