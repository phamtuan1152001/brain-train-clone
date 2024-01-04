import 'dart:async';
import 'dart:math';
import 'package:brain_train_clone_app/components/header_game.dart';
import 'package:flutter/material.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';

import '../../components/languages/button.dart';
import '../../components/languages/notification.dart';
import '../../components/toast.dart';
import '../../service/language_game_api.dart';

class ConnectWordsPage extends StatefulWidget {
  const ConnectWordsPage({super.key});

  @override
  State<ConnectWordsPage> createState() => _ConnectWordsPage();
}

class _ConnectWordsPage extends State<ConnectWordsPage> {
  final int answerDurationInSeconds = MockData.time;
  final int pointPerCorrectAnswer = 200;
  int currentIndex = 0;
  String listLetter = "data/list_letter_words.json";
  Duration answerDuration = const Duration();
  Timer? countdownTimer;
  int numberWord = 0;
  bool stopTime = false;
  bool isBack = false;
  int reduceSecondsBy = 1;
  TextEditingController controller = TextEditingController();
  late Future<String> firstCharacter;
  List<String> _answer = [' ', ' ', ' '];
  String firstLetter = "";
  int _point = 0;
  List<String> listSuccess = [""];

  @override
  void initState() {
    super.initState();
    firstCharacter = randomCharacter();
    handleStartTime();
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
    controller.dispose();
  }

  void handleStartTime() {
    answerDuration = Duration(seconds: answerDurationInSeconds);

    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    if (stopTime == false) {
      reduceSecondsBy = 1;
    } else {
      reduceSecondsBy = 0;
    }
    setState(() {
      final seconds = answerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        handleTimeEnd();
        // changeStatus(GameStatus.end);
      } else {
        answerDuration = Duration(seconds: seconds);
      }
    });
  }

  void handleTimeEnd() {
    countdownTimer!.cancel();
    displayNotification("Hết giờ", "$_point", () {
      Navigator.of(context).pop();
      setState(() {
        answerDuration = const Duration(seconds: 60);
        _point = 0;
        firstLetter = "";
        _answer = [
          ' ',
          ' ',
          ' ',
        ];
        randomCharacter();
        controller.clear();
        handleStartTime();
      });
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

  Future<String> randomCharacter() async {
    final data = await fetchRandomWord(listLetter);
    currentIndex = Random().nextInt(data["letter"].length);

    if (data.isNotEmpty) {
      String firstCharacter = data["letter"][currentIndex].split(' ')[0];
      _answer.add(firstCharacter);
      return firstCharacter;
    }
    throw Exception('Failed to load random character in the dictionary');
  }

  void onSubmit() async {
    String userAnswer = controller.text;
    String firstChar = _answer.last;
    int numberWord = _answer.length - 3;
    String checkingWord = '$firstChar $userAnswer';

    bool isValidWord = await checkValidWord(checkingWord);

    if (isValidWord) {
      if (userAnswer == _answer[numberWord + 1] &&
          userAnswer == _answer[numberWord - 1]) {
        showToastErrorMatch();
      } else {
        _answer.add(userAnswer);
        setState(() {
          _point += pointPerCorrectAnswer;
          showToastCorrect("+ 200");
        });
      }
    } else {
      showToastError();
    }

    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      // margin: const EdgeInsets.all(16),
                      height: 560,
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
                        // height:300,
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
                                            height: 330,
                                            // decoration: BoxDecoration(
                                            //   color: LightColors.kLightYellow,
                                            //   borderRadius:
                                            //       BorderRadius.circular(12),
                                            // ),
                                            child: FutureBuilder<String>(
                                              future: firstCharacter,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Column(children: [
                                                    const Text('Nối từ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 25)),
                                                    Text(
                                                        "Từ đầu tiên: ${_answer[3]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 25)),
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                              width: 100,
                                                              height: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .yellow,
                                                                  width: 5.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  _answer[_answer
                                                                          .length -
                                                                      3],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black))),
                                                          Container(
                                                              width: 100,
                                                              height: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .yellow,
                                                                  width: 5.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  _answer[_answer
                                                                          .length -
                                                                      2],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black))),
                                                        ]),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                              width: 100,
                                                              height: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .yellow,
                                                                  width: 5.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                  _answer[_answer
                                                                          .length -
                                                                      1],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black))),
                                                          Container(
                                                              width: 100,
                                                              height: 70,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: TextField(
                                                                controller:
                                                                    controller,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        height:
                                                                            1.7),
                                                                decoration:
                                                                    InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .green,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ), // OutlineInputBorder
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .yellow,
                                                                      width:
                                                                          5.0,
                                                                    ), // OutlineInputBorder
                                                                  ),
                                                                  hintText:
                                                                      'Nhập từ',
                                                                ),
                                                              ))
                                                        ]),
                                                  ]);
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      '${snapshot.error}');
                                                }

                                                // By default, show a loading spinner.
                                                return const Center(
                                                    heightFactor: 22.0,
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            )),
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
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Button(
                      padding: 20,
                      text: 'Gửi',
                      onPressed: () => onSubmit(),
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
