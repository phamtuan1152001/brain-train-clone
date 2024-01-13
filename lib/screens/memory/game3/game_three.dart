import 'package:flutter/material.dart';
import 'data/data.dart';

class MemoryThree extends StatefulWidget {
  const MemoryThree({super.key});

  @override
  State<MemoryThree> createState() => _HomePageState();
}

class _HomePageState extends State<MemoryThree> {
  void start() {
    pairs = getPairs();
    quest = getQuestion();
    getQuest();
    Future.delayed(Duration(seconds: 5), () {
      getAnswer();
    });
  }

  getQuest() {
    // List have 4 Img of pairs
    roundPairs = pickRandomItemsAsListWithSubList(pairs, 4);
    // List get 1 Img of roundPairs
    visiblePairs = pickRandomItemsAsListWithSubList(roundPairs, 1);
    // Get index of item visiblePairs in roundPairs
    index = roundPairs.indexWhere((element) => visiblePairs.contains(element));
    selected = true;
  }

  getAnswer() {
    pairs.removeWhere((element) => roundPairs.contains(element));
    remain = pickRandomItemsAsListWithSubList(pairs, 3);
    remain = remain + visiblePairs;
    setState(() {
      roundPairs.removeWhere((element) => visiblePairs.contains(element));
      roundPairs.insert(index, quest[0]);
      selected = false;
    });
  }

  checkResult() {
    pairs = pairs + visiblePairs;
  }

  displayAnswer() {
    return GridView(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      children: List.generate(remain.length, (index) {
        return Tile(
          imageAssetPath: remain[index].getImageAssetPath(),
          parent: this,
          tileIndex: index,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Color background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        //
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            Text(
              "$points/800",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const Text(
              "Points",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),

            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              children: List.generate(roundPairs.length, (index) {
                return Tile(
                  imageAssetPath: roundPairs[index].getImageAssetPath(),
                  parent: this,
                  tileIndex: index,
                );
              }),
            ),
            const Divider(
              thickness: 5,
            ),
            displayAnswer(),
          ],
        ),
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
  // const Tile({super.key});

  @override
  // State<Tile> createState() => _TileState();
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // widget.parent.setState(() {
        //   widget.parent.checkResult();
        // });
        if (!selected) {
          setState(() {
            print("--------START----------");
            roundPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedImageAssetPath != []) {
            selectedImageAssetPath.add(widget.imageAssetPath);
            print("selectedImageAssetPath: $selectedImageAssetPath");
            contain = remain.where((element) =>
                element.imageAssetPath == selectedImageAssetPath[0]);
            if (contain.isEmpty) {
              // Value not exist
              print("Not check");
            } else {
              // Value exist
              print("Check here");

              // Check answer
              if (selectedImageAssetPath[0] == visiblePairs[0].imageAssetPath) {
                // Correct
                print("Correct");
              } else {
                // Wrong
                print("wrong");
              }
            }
            selectedImageAssetPath = [];
          } else {
            print("Here");
          }
          print("---------------------");
          print(pairs[widget.tileIndex].getIsSelected());
          print("You click me");
          print(widget.imageAssetPath);
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 10,
          child: Center(
            child: Image.asset(widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
