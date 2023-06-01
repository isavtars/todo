import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllite/logic/bainding/bainding.dart';
import 'package:sqllite/screen/home_screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'sqlcrud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen2(),
      initialBinding: MyBainding(),
    );
  }
}
