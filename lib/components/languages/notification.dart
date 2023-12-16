import 'package:flutter/material.dart';
import 'package:brain_train_clone_app/components/languages/button.dart';

class NotificationComponents extends StatelessWidget {
  const NotificationComponents({
    super.key,
    required this.title,
    required this.content,
    required this.callback,
    required this.numberWord,
  });
  final String title;
  final String content;
  final Function callback;
  final int numberWord;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.red,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF9C4), Color(0xFFF9A825)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Số từ đúng: $numberWord",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Điểm của bạn:        ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'images/poly-twist-knots.png',
                                  width: 170,
                                ),
                                Text(
                                  content,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Button(
          padding: 0,
          text: 'Chơi Lại',
          onPressed: () => callback(),
        ),
      ],
    );
  }
}
