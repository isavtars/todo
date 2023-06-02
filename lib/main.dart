import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllite/logic/bainding/bainding.dart';

import 'screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
      initialBinding: MyBainding(),
    );
  }
}
