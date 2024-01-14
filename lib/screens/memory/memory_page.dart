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
    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteGenerator.homePage);
          },
          child: Image.asset(
            'assets/math/go-back-black.png',
            scale: 2.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#fffffe"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select a Memory Game",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              SizedBox(height: scrHeight / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Navigator.of(context).pushNamed(RouteGenerator.memoryTwo);
                    },
                    child: const Text('Game 2'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
