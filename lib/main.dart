import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllite/logic/bainding/bainding.dart';

import 'logic/themchanger.dart';
import 'screen/splashscreen.dart';
import 'utils/todoapp_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemModeChange(),
      builder: (themcontroller) {
        return GetMaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          themeMode: themcontroller.themeMode,
          theme: TodoThemsData.lightTheme,
          darkTheme: TodoThemsData.darkTheme,
          home: const SplashScreen(),
          initialBinding: MyBainding(),
        );
      },
    );
  }
}
