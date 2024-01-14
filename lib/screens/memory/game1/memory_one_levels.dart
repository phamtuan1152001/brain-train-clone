import 'package:brain_train_clone_app/screens/memory/game1/data/data.dart';
import 'package:brain_train_clone_app/screens/memory/game1/memory_one.dart';
import 'package:brain_train_clone_app/screens/memory/memory_page.dart';
import 'package:flutter/material.dart';

import 'widgets/level_card.dart';

class MemoryOneLevel extends StatefulWidget {
  const MemoryOneLevel({super.key});

  @override
  State<MemoryOneLevel> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<MemoryOneLevel> {
  final isOPenLevel _isOpenLevel = isOPenLevel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MemoryPage()));
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Levels",
                  style: TextStyle(fontSize: 23),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return LevelCard(
                level: index + 1,
                // starts: 3,
                isOpen: index <= _isOpenLevel.isOpen(),
                onPressed: () {
                  int chooseLevel = index + 1;
                  if (chooseLevel == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemoryOne(dataLevel.one)),
                    );
                  } else if (chooseLevel == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemoryOne(dataLevel.two)),
                    );
                  } else if (chooseLevel == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemoryOne(dataLevel.three)),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
