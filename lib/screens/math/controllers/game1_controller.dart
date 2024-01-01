import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/game1_data_generator.dart';
import '../game1_screens/g1_congrat_screen.dart';

class Game1Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // to animate progress bar
  late Animation _animation;
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  Game1DataGenerator dataGenerator = Get.put(Game1DataGenerator());

  int playTime = 60;

  bool consecutive = false;
  int consecutiveCorrectTimes = 0;

  List<int> pointList = [];
  RxInt point = 0.obs;
  RxInt get getPoint => point;

  int _responseTime = 0;
  int _totalResponseTime = 0;
  int get totalResponseTime => _totalResponseTime;

  @override
  void onInit() {
    // fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: playTime), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    // when 60s ends, go to the next question
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _pageController.dispose();
    super.onClose();
  }

  // generate question set to display in the game
  List<List<Pair>> getQuestions() {
    List<List<Pair>> playQuestions = [];

    for (int i = 0; i < 5; i++) {
      playQuestions.add(dataGenerator.genQuestionLv1);
      pointList.add(100);
    }
    for (int i = 0; i < 9; i++) {
      playQuestions.add(dataGenerator.genQuestionLv2);
      pointList.add(150);
    }
    for (int i = 0; i < 10; i++) {
      playQuestions.add(dataGenerator.genQuestionLv3);
      pointList.add(200);
    }
    for (int i = 0; i < 24; i++) {
      playQuestions.add(dataGenerator.genQuestionLv4);
      pointList.add(300);
    }
    for (int i = 0; i < 24; i++) {
      playQuestions.add(dataGenerator.genQuestionLv5);
      pointList.add(400);
    }
    for (int i = 0; i < 14; i++) {
      playQuestions.add(dataGenerator.genQuestionLv6);
      pointList.add(500);
    }
    for (int i = 0; i < 14; i++) {
      playQuestions.add(dataGenerator.genQuestionLv7);
      pointList.add(600);
    }
    return playQuestions;
  }

  void checkAns(List<Pair> options, int selectedInx) {
    _isAnswered = true;
    _selectedAns = selectedInx;

    // calculate total reponse time on the whole question set
    _responseTime = (animation.value * playTime).round();
    _totalResponseTime += _responseTime;

    // check which option is correct
    int opt1 = options[0].value;
    int opt2 = options[1].value;
    if (opt1 < opt2) {
      _correctAns = 0;
    }
    if (opt1 > opt2) {
      _correctAns = 1;
    }

    if (_selectedAns == _correctAns) {
      _numOfCorrectAns++;
      consecutive = true;
      point += pointList[_questionNumber.value - 1];
    } else {
      consecutive = false;
      // for each incorrect ans => minus play time by 1s
      playTime -= 1;
      Fluttertoast.showToast(
        msg: '-1 giây',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 197, 52, 42),
        textColor: Colors.white,
      );
    }

    // to keep track the number of correct answer in a row
    if (consecutive == true) {
      consecutiveCorrectTimes++;
    } else {
      consecutiveCorrectTimes = 0;
    }

    // 3 correct ans in a row => add 10s to play time
    if (consecutiveCorrectTimes == 3) {
      playTime += 10;
      consecutiveCorrectTimes = 0;
      Fluttertoast.showToast(
        msg: '+10 giây',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 25, 132, 29),
        textColor: Colors.white,
      );
    }

    // stop the progress bar
    _animationController.stop();
    update();

    // wait 1500 milliseconds before go to the next question
    Timer(const Duration(milliseconds: 1500), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != getQuestions().length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // reset progress bar
      _animationController.reset();

      // then start it agian
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(() => const Math1CongratScreen());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index + 1;
  }
}
