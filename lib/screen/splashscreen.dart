import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animationx;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 0, end: 0.25).animate(animationController);

    animationController.forward();

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
      decoration: const BoxDecoration(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimationLogo(
              animation: animation,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text(
              "Todo app",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 32,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    ));
  }
}

class AnimationLogo extends AnimatedWidget {
  const AnimationLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value * 25,
      child: AnimatedPositioned(
        top: animation.value * 10,
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          child: Image.asset(
            'assets/images/ic_launcher.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
