import 'package:brain_train_clone_app/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'g2_globals.dart';

class Math2LevelsScreen extends StatelessWidget {
  const Math2LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/mathPage'));
        Navigator.of(context).pushNamed(RouteGenerator.mathPage);
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/mathPage'));
              Navigator.of(context).pushNamed(RouteGenerator.mathPage);
            },
            child: Image.asset(
              'assets/math/go-back.png',
              scale: 2.5,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/math/level.png',
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: scrHeight / 30),
              const Text(
                'Cấp độ',
                style: TextStyle(
                  fontSize: 34,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: scrHeight / 60),
              const Text(
                'Hãy chọn cấp độ bạn muốn chơi:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'RobotoSlab',
                ),
              ),
              SizedBox(height: scrHeight / 20),

              //! level 1
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 46, 46, 46)),
                  elevation: MaterialStateProperty.all(1),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 25)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (_) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  glbLevel.value = 1;
                  Navigator.of(context).pushNamed(RouteGenerator.sum);
                },
                child: const Text(
                  'Độ khó 1',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: scrHeight / 60),

              //! level 2
              ElevatedButton(
                style: (glbUnblock == true && glbLevel.value == 1) ||
                        glbLevel >= 2
                    ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 46, 46, 46)),
                        elevation: MaterialStateProperty.all(1),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 25)),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 174, 174, 174)),
                        elevation: MaterialStateProperty.all(1),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 25)),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                onPressed: () async {
                  (glbUnblock == true && glbLevel.value == 1) || glbLevel >= 2
                      ? {
                          glbLevel.value = 2,
                          glbUnblock = false,
                          Navigator.of(context).pushNamed(RouteGenerator.sum),
                        }
                      : null;
                },
                child: const Text(
                  'Độ khó 2',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: scrHeight / 60),

              //! level 3
              ElevatedButton(
                style: (glbUnblock == true && glbLevel.value == 2) ||
                        glbLevel >= 3
                    ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 46, 46, 46)),
                        elevation: MaterialStateProperty.all(1),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 25)),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 174, 174, 174)),
                        elevation: MaterialStateProperty.all(1),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 25)),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                onPressed: () async {
                  (glbUnblock == true && glbLevel.value == 2) || glbLevel >= 3
                      ? {
                          glbLevel.value = 3,
                          glbUnblock = false,
                          Navigator.of(context).pushNamed(RouteGenerator.sum),
                        }
                      : null;
                },
                child: const Text(
                  'Độ khó 3',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
