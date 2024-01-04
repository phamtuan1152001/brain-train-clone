import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:brain_train_clone_app/screens/languages/common/index.dart'
    show handleCheck;

// @components
import 'package:brain_train_clone_app/components/languages/notification.dart';
import 'package:brain_train_clone_app/components/header_game.dart';

// @common
import 'package:brain_train_clone_app/common/light_colors.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';
import '../../components/languages/button.dart';
import '../../service/language_game_api.dart';

class NextWordsPage extends StatefulWidget {
  const NextWordsPage({super.key});

  @override
  State<NextWordsPage> createState() => _NextWordsPage();
}

class _NextWordsPage extends State<NextWordsPage> {
  String listWord = "data/list_words.json";
  final int answerDurationInSeconds = MockData.time;
  List<String> _firstWord = [""];
  int currentIndex = 0;
  List wordList = [];
  Timer? countdownTimer;
  bool isBack = false;
  int reduceSecondsBy = 1;
  int score = 0;
  String wordInput = "";
  int statusCode = 0;
  bool stopTime = false;
  int numberWord = 0;
  String firstWord = "";
  TextEditingController controllerInput = TextEditingController();
  Duration answerDuration = const Duration();
  List<String> listSuccess = [""];

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
    displayNotification("Hết giờ", "$score", () {
      Navigator.of(context).pop();
      setState(() {
        answerDuration = const Duration();
        score = 0;
        _firstWord = [''];
        firstWord = "";
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

  void randomCharacter() async {
    final data = await fetchRandomWord(listWord);
    currentIndex = Random().nextInt(data["word"].length);

    setState(() {
      String firstCharacter = data["word"][currentIndex].split(' ')[0];
      _firstWord.add(firstCharacter);
      firstWord = _firstWord[1];
      wordList = data["word"];
    });
  }

  void onSubmit() async {
    numberWord = _firstWord.length - 1;
    String userAnswer = controllerInput.text;
    String firstWord = _firstWord[1];
    String checkingWord = "$firstWord $userAnswer";

    bool success = await handleCheck(
        userAnswer: userAnswer,
        userInput: firstWord,
        numberWord: numberWord,
        checkingWord: checkingWord,
        ans: _firstWord,
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      height: 350,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 230, 209, 24),
                            Color.fromARGB(255, 227, 241, 28)
                          ],
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
                        body: Container(
                          child: Center(
                            child: Column(
                              children: [
                                HeaderGame(
                                    isBack: isBack,
                                    context: context,
                                    answerDuration: answerDuration,
                                    answerDurationInSeconds:
                                        answerDurationInSeconds),
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
                                                    "Nhập từ thích hợp bắt đầu bằng chữ $firstWord : ",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Text(
                                                    wordInput == ""
                                                        ? "$firstWord _____"
                                                        : "$firstWord $wordInput",
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
                  const SizedBox(height: 50),
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
                              maxLength: 7,
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
                          child: Button(
                            padding: 20,
                            text: 'Gửi',
                            onPressed: () => checkResult(),
                          ),
                        ),
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
