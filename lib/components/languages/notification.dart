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
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF97E8B5),
                  Color(0xFF5CB67F),
                ],
                stops: [0.0, 1.0],
                transform:
                    GradientRotation(220.55 * (3.141592653589793 / 180.0)),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.red,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 20),
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
                                Text(
                                  content,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
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
