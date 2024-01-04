import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/languages/alert.dart';

// @common
import 'package:brain_train_clone_app/common/light_colors.dart';

// import '../screens/languages/common/display_my_dialog.dart';

class HeaderGame extends StatelessWidget {
  const HeaderGame({
    super.key,
    required this.isBack,
    required this.context,
    required this.answerDuration,
    required this.answerDurationInSeconds,
  });
  final bool isBack;
  final dynamic context;
  final Duration answerDuration;
  final int answerDurationInSeconds;

  Future<bool?> displayMyDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertComponents(
          questionText: "Bạn có muốn thoát ra ?",
          yesText: "Có",
          noText: "Không",
          flag: isBack,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final isBack = await displayMyDialog(context);
                      if (isBack == true) {
                        Navigator.pop(context, isBack);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                    ),
                    color: Colors.black,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: LightColors.kLightYellow,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor:
                        answerDuration.inSeconds / answerDurationInSeconds,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green[300],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 30,
                child: Consumer(
                  builder: (context, ref, child) {
                    return Text('${answerDuration.inSeconds} seconds');
                  },
                ),
              ),
              const Positioned(
                right: 10,
                child: Icon(
                  Icons.timer,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
