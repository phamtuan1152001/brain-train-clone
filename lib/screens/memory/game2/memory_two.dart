import 'package:flutter/material.dart';

import 'data/data.dart';
import 'widgets/score_board.dart';

class MemoryTwo extends StatefulWidget {
  const MemoryTwo({super.key});

  @override
  State<MemoryTwo> createState() => _HomePageState();
}

class _HomePageState extends State<MemoryTwo> {
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

  void winGame() {
    _showNotify("Bạn Thắng", "Điểm: $score", "Chơi lại", () {
      Navigator.of(context).pop();
      setState(() {
        start();
      });
    });
  }

  void loseGame() {
    _showNotify("Bạn Thua", "Điểm: $score", "Chơi lại", () {
      Navigator.of(context).pop();
      setState(() {
        start();
      });
    });
  }

  getImage() {
    return Column(
      children: [
        GridView(
          padding: EdgeInsets.all(20),
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: List.generate(getImg.length, (index) {
            return Tile(
                imageAssetPath: getImg[index].getImageAssetPath(),
                tileIndex: index,
                parent: this);
          }),
        ),
      ],
    );
  }

  void start() {
    score = 0;
    pairs = getPairs();
    getImg = pickRandomItemsAsListWithSubList(pairs, 3);
    pairs.removeWhere((element) => getImg.contains(element));
  }

  void next() {
    remain = getImg + pickRandomItemsAsListWithSubList(pairs, 1);
    pairs.removeWhere((element) => remain.contains(element));
    getImg = remain;
    getImg.shuffle();
  }

  @override
  void initState() {
    // TODO: implement initState
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              "Memory Game",
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
              scoreBoard("Điểm", "$score"),
              scoreBoard("Cấp độ", "1"),
            ],
          ),
          getImage(),
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
    required this.tileIndex,
    required this.parent,
  });
  // const Tile({super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("------------");
        if (!selected) {
          // setState(() {
          //   pairs[widget.tileIndex].setIsSelected(true);
          // });
          checkString = selectedImageAssetPath.where((element) =>
              element == getImg[widget.tileIndex].getImageAssetPath());

          if (checkString.isEmpty) {
            // Correct
            print("Value not exists");
            print(getImg[widget.tileIndex].getImageAssetPath());
            // selectedTileIndex.add(widget.tileIndex);
            selectedImageAssetPath
                .add(getImg[widget.tileIndex].getImageAssetPath());

            // if pairs = 8 then selectedImageAssetPath.length = pairs - 2
            if (selectedImageAssetPath.length == 6) {
              print("Stop here");
              selectedImageAssetPath = [];
              // setState(() {
              //   score = 0;
              // });
              widget.parent.setState(() {
                // widget.parent.start();
                widget.parent.winGame();
              });
            } else {
              setState(() {
                score += 500;
              });
              widget.parent.setState(() {
                widget.parent.next();
              });
            }
          } else {
            // Wrong
            print("Value exists");
            selectedImageAssetPath = [];

            widget.parent.setState(() {
              // widget.parent.start();
              widget.parent.loseGame();
            });
          }

          // print(selectedTileIndex);
          print(selectedImageAssetPath);
          print("You click me");
        }
      },
      child: Container(
        // margin: EdgeInsets.all(1),
        child: Card(
          elevation: 10,
          child: Center(
            child: Image.asset(
              widget.imageAssetPath,
            ),
          ),
        ),
      ),
    );
  }
}
