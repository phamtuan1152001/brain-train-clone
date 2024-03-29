import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:brain_train_clone_app/components/card_item.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';

import '../../router/routers.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePage();
}

class _LanguagePage extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final languageGames = MockData.languageGames;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#fffffe"),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/homepage'));
                      Navigator.of(context).pushNamed(RouteGenerator.homePage);
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  'Selecting A Language Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: HexColor("#020826"),
                      fontSize: 25,
                      letterSpacing: 1),
                ),
              ),
              // size box test
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  height: 500,
                  enlargeCenterPage: true,
                  padEnds: true,
                  viewportFraction: .7,
                ),
                items: [
                  for (var languageGame in languageGames)
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(languageGame['pathName']);
                      },
                      child: CardItem(
                          image: languageGame['image'],
                          icon: languageGame['icon'],
                          title: languageGame['title'],
                          description: languageGame['description'],
                          paddingTop: languageGame['paddingTop'],
                          paddingLeft: languageGame['paddingLeft'],
                          padding: languageGame['padding'],
                          color: Color(languageGame['color'])),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
