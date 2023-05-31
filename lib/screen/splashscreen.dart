import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Color(0xff47BBEA),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/spalshlogo.jpg',
              ))),
      child: Stack(
        children: [
          Positioned(
              bottom: size.height * 0.2,
              left: size.width * 0.32,
              child: const Text(
                "@vatar",
                style: TextStyle(
                    color: Colors.white10,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              )),
          Positioned(
              bottom: size.height * 0.25,
              left: size.width * 0.28,
              child: const AnimatedPositioned(
                // top: size.width * 0.28,
                // bottom: size.height * 0.25,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: Text(
                  "Todo App",
                  style: TextStyle(
                      color: Color.fromARGB(246, 6, 192, 216),
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    ));
  }
}
