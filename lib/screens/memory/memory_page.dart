import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../router/routers.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPage();
}

class _MemoryPage extends State<MemoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#fffffe"),
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.memoryOneLevel);
                        },
                        child: const Text('Game 1'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.memoryTwo);
                        },
                        child: const Text('Game 2'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.memoryThree);
                        },
                        child: const Text('Game 3'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
