import 'package:brain_train_clone_app/router/routers.dart';
import 'package:flutter/material.dart';

class MathPage extends StatefulWidget {
  const MathPage({super.key});

  @override
  State<MathPage> createState() => _MathPage();
}

class _MathPage extends State<MathPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.smaller);
              },
              child: const Text('Game 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.sumLevels);
              },
              child: const Text('Game 2'),
            ),
          ],
        ),
      ),
    );
  }
}
