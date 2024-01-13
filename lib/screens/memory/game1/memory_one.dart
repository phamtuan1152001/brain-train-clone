import 'dart:async';
import 'package:flutter/material.dart';

import 'data/data.dart';
import 'memory_one_levels.dart';
import 'widgets/score_board.dart';

class MemoryOne extends StatefulWidget {
  final dataLevel _level;
  MemoryOne(this._level);
  // const HomePage({super.key});

  @override
  State<MemoryOne> createState() => _HomePageState(_level);
}

class _HomePageState extends State<MemoryOne> {
  _HomePageState(this._level);
  int _left = 1;
  dataLevel _level;
  int numOfRow = 0;
  double numOfPairs = 0;

  // LevelCard _levelcard = LevelCard();
  Duration timerDuration = const Duration(seconds: 13);

  void setCountdown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        finishGame();
      } else {
        timerDuration = Duration(seconds: seconds);
      }
    });
  }

  Timer? countdownTimer;
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountdown());
  }

  chooseLevel() {
    if (_level == dataLevel.one) {
      pairs = getPairs_1();
      pairs.shuffle();
      visiblePairs = pairs;
      selected = true;
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          selected = false;
          visiblePairs = getQuestion_1();
        });
      });
      numOfRow = 3;
      numOfPairs = 1;
    } else if (_level == dataLevel.two) {
      pairs = getPairs_2();
      pairs.shuffle();
      visiblePairs = pairs;
      selected = true;

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          selected = false;
          visiblePairs = getQuestion_2();
        });
      });
      numOfRow = 3;
      numOfPairs = 2;
    } else if (_level == dataLevel.three) {
      pairs = getPairs_3();
      pairs.shuffle();
      visiblePairs = pairs;
      selected = true;

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          selected = false;
          visiblePairs = getQuestion_3();
        });
      });
      numOfRow = 4;
      numOfPairs = 3;
    }
    return numOfPairs;
  }

  void restart() {
    startTimer();
    timerDuration = const Duration(seconds: 13);
    _left = 1;
    chooseLevel();
  }

  Future<void> _showNotify(
      String title, String content, String contents, Function callback) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(content),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => callback(),
            child: Text(contents),
          )
        ],
      ),
    );
  }

  void finishGame() {
    countdownTimer!.cancel();
    _showNotify("Bạn thua", "Điểm: $score", "Chơi lại", () {
      Navigator.of(context).pop();
      setState(() {
        if (score > 0 && score < 600) {
          score = 0;
        } else if (score >= 600 && score < 1200) {
          score = 600;
        } else if (score >= 1200) {
          score = 1200;
        }
        restart();
      });
    });
  }

  void countTries() {
    countdownTimer!.cancel();
    _showNotify("Tiếp tục", "$tries/12", "Chơi tiếp", () {
      Navigator.of(context).pop();
      setState(() {
        restart();
      });
    });
  }

  void winGame() {
    countdownTimer!.cancel();
    _showNotify("Bạn Thắng", "Điểm: $score", "Next Level", () {
      Navigator.of(context).pop();
      setState(() {
        tries = 3;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemoryOneLevel(),
            ));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // countdownTimer!.cancel();
    tries = 1;
    restart();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: () async => false,
    //   child:

    // );
    return Scaffold(
      backgroundColor: Color(0xFFe55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "$tries/12",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("Time", "${timerDuration.inSeconds}"),
              scoreBoard("Score", "$score"),
            ],
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numOfRow,
            ),
            children: List.generate(visiblePairs.length, (index) {
              return Tile(
                  imageAssetPath: visiblePairs[index].getImageAssetPath(),
                  parent: this,
                  tileIndex: index);
            }),
          )
        ],
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imageAssetPath;
  int tileIndex;
  _HomePageState parent;
  Tile({
    required this.imageAssetPath,
    required this.parent,
    required this.tileIndex,
  });

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          print("---------------------");
          print(tries);
          print("---------------------");

          if (selectedImageAssetPath == "") {
            selectedTileIndex = widget.tileIndex;
            selectedImageAssetPath =
                pairs[widget.tileIndex].getImageAssetPath();
            print(selectedTileIndex);

            if (selectedImageAssetPath == "assets/yellow.png") {
              // Correct
              print('Correct');

              selected = true;
              // Lật hình đúng đầu tiên
              setState(() {
                pairs[widget.tileIndex].setIsSelected(true);
              });
              print(widget.parent.numOfPairs);
              if (widget.parent._left == widget.parent.numOfPairs) {
                // You win
                print("You Win");

                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    tries++;
                    score = score + 200;
                  });
                  if (tries <= 3) {
                    widget.parent.setState(() {
                      widget.parent.countTries();
                    });
                  } else {
                    widget.parent.setState(() {
                      widget.parent.winGame();
                    });
                  }
                });
              } else {
                // Continue
                print('Continue');

                selected = true;
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    selected = false;
                    pairs[widget.tileIndex].setIsSelected(true);
                  });
                  widget.parent.setState(() {
                    widget.parent._left++;
                  });
                });
                print(widget.parent._left);
              }
            } else {
              // Wrong
              print("Wrong");

              selected = true;
              Future.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                  selected = false;
                  tries = 1;
                  pairs[widget.tileIndex].setIsSelected(true);
                  if (score > 0) {}
                });
                widget.parent.setState(() {
                  widget.parent.finishGame();
                });
              });
            }
            selectedImageAssetPath = "";
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Image.asset(pairs[widget.tileIndex].getIsSelected()
            ? pairs[widget.tileIndex].getImageAssetPath()
            : widget.imageAssetPath),
      ),
    );
  }
}
