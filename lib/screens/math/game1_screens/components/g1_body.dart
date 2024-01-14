import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/game1_controller.dart';
import '../../models/game1_data_generator.dart';
import 'g1_question_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Game1Controller _questionController = Get.put(Game1Controller());
    final List<List<Pair>> questionSet = _questionController.getQuestions();
    double scrHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => Text.rich(
                              TextSpan(
                                text: 'ĐIỂM SỐ ',
                                style: const TextStyle(
                                  color: Color.fromRGBO(139, 148, 188, 1),
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${_questionController.getPoint}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(139, 148, 188, 1),
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => Text.rich(
                              TextSpan(
                                text: 'THỜI GIAN CÒN LẠI ',
                                style: const TextStyle(
                                  color: Color.fromRGBO(139, 148, 188, 1),
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${_questionController.timeLeft}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(139, 148, 188, 1),
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: scrHeight / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text: "Câu hỏi ${_questionController.questionNumber}",
                      style: const TextStyle(
                        color: Color.fromRGBO(139, 148, 188, 1),
                        fontSize: 34,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  // block swipe to the next question
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateQuestionNumber,
                  itemCount: questionSet.length,
                  itemBuilder: (context, index) => QuestionCard(
                    question: questionSet[index],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
