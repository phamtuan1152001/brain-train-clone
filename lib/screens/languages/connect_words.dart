import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:brain_train_clone_app/components/card_item.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';

import '../../components/languages/alert.dart';
import '../../components/languages/notification.dart';
import '../../components/toast.dart';
import '../../service/language_game_api.dart';

class ConnectWordsPage extends StatefulWidget {
  const ConnectWordsPage({super.key});

  @override
  State<ConnectWordsPage> createState() => _ConnectWordsPage();
}

class _ConnectWordsPage extends State<ConnectWordsPage> {
  final int answerDurationInSeconds = 10;
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
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
    controller.dispose();
  }

  void startTimer() {
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
        setEndTimer();
        // changeStatus(GameStatus.end);
      } else {
        answerDuration = Duration(seconds: seconds);
      }
    });
  }

  void setEndTimer() {
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
        startTimer();
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

    // setState(() {
    //   String firstCharacter = data["letter"][currentIndex].split(' ')[0];
    //   _answer.add(firstCharacter);
    //   return firstCharacter;
    // });
  }

  Future<bool> checkValidWord(String word) async {
    Map<String, String> headers = {'Content-type': 'application/json'};
    final response = await http.post(Uri.parse('$validlanguagesUrl'),
        headers: headers, body: jsonEncode({'text': word}));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  void handleClickCheck() async {
    String userAnswer = controller.text;
    String firstChar = _answer[_answer.length - 1];
    numberWord = _answer.length - 3;
    String checkingWord = '$firstChar $userAnswer';

    bool isValidWord = await checkValidWord(checkingWord);
    if (isValidWord) {
      if ("$userAnswer" == _answer[_answer.length - 2] &&
          "$userAnswer" == _answer[_answer.length - 4]) {
        showToastErrorMatch();
      }
      if ("$userAnswer" != _answer[_answer.length - 2] ||
          "$userAnswer" != _answer[_answer.length - 4]) {
        _answer.add(userAnswer);
        setState(() {
          _point += pointPerCorrectAnswer;
          // Restart timer
          showToastCorrect("+ 200");
          // answerDuration = Duration(seconds: answerDurationInSeconds);
        });
      }
    } else {
      showToastError();
    }

    controller.text = '';
  }

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
    final seconds = answerDuration.inSeconds;
    return WillPopScope(
      onWillPop: () async {
        final isBack = await displayMyDialog(context);
        return isBack ?? false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Positioned(
                bottom: -40,
                left: -5,
                right: -230,
                child: Image(
                  image: AssetImage('assets/images/cat-dance.gif'),
                  height: 200,
                  width: 400,
                  //   width:400,
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      // margin: const EdgeInsets.all(16),
                      height: 460,
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
                                                  await displayMyDialog(
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
                                          // IconButton(
                                          //   onPressed: () {
                                          //     stopTime = true;
                                          //     setEndTimer();
                                          //   },
                                          //   icon: const Icon(
                                          //     Icons.flag_circle_rounded,
                                          //     size: 40,
                                          //   ),
                                          //   color: Colors.black,
                                          // ),
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
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(30),
                                  //   color: LightColors.kLightYellow,
                                  // ),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Consumer(
                                        builder: (context, ref, child) {
                                          // final questions = ref.watch(questionsProvider);
                                          return FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor:
                                                answerDuration.inSeconds /
                                                    answerDurationInSeconds,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.green[300],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Image.asset(
                                      //   'assets/images/slow-loading.png',
                                      //   width: 3980,
                                      //   height:400,
                                      // ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: controller.text.isNotEmpty
                            ? () => handleClickCheck()
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[600],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            textStyle: const TextStyle(fontSize: 24)),
                        child: const Text('Gửi'),
                      )
                    ],
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
