import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brain_train_clone_app/constants/mock_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Color color = Color(0xeaddcff);
    final cards = MockData.cards;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: /* 900 */ double.infinity,
        color: HexColor("#fffffe"),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Welcome to Brain Train',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: HexColor("#020826"), fontSize: 25, letterSpacing: 1),
              ),
            ),
            for (var card in cards)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: HexColor("#eaddcf"),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            card['title'],
                            style: TextStyle(color: HexColor("#020826")),
                          ),
                        ),
                        subtitle: Center(
                          child: Text(
                            card['description'],
                            style: TextStyle(color: HexColor("#716040")),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Image.asset(
                          card['image'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                // padding: const EdgeInsets.all(16.0),
                                // textStyle: const TextStyle(fontSize: 20),
                                backgroundColor: HexColor("#8c7851")),
                            onPressed: () {},
                            child: const Text('Start playing'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    ));
  }
}
