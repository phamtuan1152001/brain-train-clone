import 'dart:async';
import 'package:brain_train_clone_app/screens/languages/common/index.dart';
// import 'package:flutter/services.dart';
import 'dart:math';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:brain_train_clone_app/service/language_game_api.dart'
    show fetchRandomLetter;
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// @components
// import 'package:brain_train_clone_app/components/toast.dart';
import 'package:brain_train_clone_app/components/languages/notification.dart';
import 'package:brain_train_clone_app/data/data_onborad/data_languages_1.dart';
import '../../components/languages/alert.dart';

// @common
import 'package:brain_train_clone_app/common/light_colors.dart';

class FindWordsPage extends StatefulWidget {
  const FindWordsPage({super.key});

  @override
  State<FindWordsPage> createState() => _FindWordsPage();
}

class _FindWordsPage extends State<FindWordsPage> {
  String listLetter = 'data/list_letters.json';
  final int answerDurationInSeconds = 50;
  List<String> _firstLetter = [""];
  String firstLetter = "";
  String wordInput = "";
  int statusCode = 0;
  bool stopTime = false;
  bool isBack = false;
  int reduceSecondsBy = 1;
  int score = 0;
  int currentIndex = 0;
  List letterList = [];
  Timer? countdownTimer;
  int numberWord = 0;
  int currentPage = 0;
  List<String> listSuccess = [""];
  // PageController _pageController = PageController(initialPage: 0);
  TextEditingController controllerInput = TextEditingController();
  Duration answerDuration = const Duration();

  @override
  void initState() {
    super.initState();
    randomCharacter();
    handleStartTimer();
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
    controllerInput.dispose();
  }

  void handleTimeEnd() {
    countdownTimer!.cancel();
    displayNotification("HẾT GIỜ", "$score", () {
      Navigator.of(context).pop();
      setState(() {
        answerDuration = const Duration();
        score = 0;
        _firstLetter = [''];
        firstLetter = "";
        wordInput = "";
        randomCharacter();
        controllerInput.clear();
        handleStartTimer();
      });
    });
  }

  void handleCountDown() {
    if (stopTime == false) {
      reduceSecondsBy = 1;
    } else {
      reduceSecondsBy = 0;
    }
    setState(() {
      final seconds = answerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        handleTimeEnd();
      } else {
        answerDuration = Duration(seconds: seconds);
      }
    });
  }

  void handleStartTimer() {
    answerDuration = Duration(seconds: answerDurationInSeconds);

    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => handleCountDown());
  }

  void onSubmit() async {
    String userAnswer = controllerInput.text;
    String firstLetter = _firstLetter[1];
    String checkingWord = "$firstLetter$userAnswer";
    numberWord = _firstLetter.length - 1;

    bool success = await handleCheck(
        userAnswer: userAnswer,
        userInput: firstLetter,
        numberWord: numberWord,
        checkingWord: checkingWord,
        ans: _firstLetter,
        listSuccess: listSuccess);

    if (success) {
      score += 200;
    }

    setState(() {
      controllerInput.clear();
      wordInput = "";
    });
  }

  void checkResult() {
    if (wordInput.isNotEmpty) {
      onSubmit();
    }
  }

  void randomCharacter() async {
    final data = await fetchRandomLetter(listLetter);
    currentIndex = Random().nextInt(data["letter"].length);
    setState(() {
      String firstCharacter = data["letter"][currentIndex].split(' ')[0];
      _firstLetter.add(firstCharacter);
      firstLetter = _firstLetter[1];
      letterList = data["letter"];
    });
  }

  Future<void> displayNotification(
      String title, String content, Function callback) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => NotificationComponents(
            title: title,
            content: content,
            callback: callback,
            numberWord: listSuccess.length - 1));
  }

  Future<bool?> displayMyDiaglog(BuildContext context) {
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
    return WillPopScope(
      onWillPop: () async {
        final isBack = await displayMyDiaglog(context);
        return isBack ?? false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: LightColors.kLightYellow,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // margin: const EdgeInsets.all(16),
                      height: 350,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFD740), Color(0xFFF9A825)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),

                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        // height:300,

                        body: Container(
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final isBack =
                                                  await displayMyDiaglog(
                                                      context);
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
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                                answerDuration.inSeconds /
                                                    answerDurationInSeconds,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: LightColors.kDarkGreen,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        left: 10,
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            return Text(
                                                '${answerDuration.inSeconds} seconds');
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
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 20,
                                            right: 20,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 22),
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: LightColors.kLightYellow,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 30,
                                                  bottom: 10,
                                                ),
                                                child: Text(
                                                    "Nhập từ thích hợp bắt đầu bằng chữ $firstLetter : ",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 25)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Text(
                                                    wordInput == ""
                                                        ? "$firstLetter _____"
                                                        : "$firstLetter$wordInput",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 30)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // Add the line below
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    // padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.hardEdge,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xffffe0b2),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    // Add the line below
                    margin: const EdgeInsets.only(left: 35.0, right: 35.0),
                    clipBehavior: Clip.hardEdge,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xfffff3e0),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: TextField(
                              controller: controllerInput,
                              textAlign: TextAlign.center,
                              maxLength: 6,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                              onChanged: (text) {
                                setState(() {
                                  wordInput = text;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "nhập từ ở đây",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                checkResult();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow[600],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 14),
                                  textStyle: const TextStyle(fontSize: 24)),
                              child: const Text('Gửi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20)),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
