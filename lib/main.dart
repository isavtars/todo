import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqllite/logic/bainding/bainding.dart';
import 'package:sqllite/utils/app_styles.dart';
import 'package:timezone/data/latest_10y.dart';

import 'logic/themchanger.dart';
import 'screen/splashscreen.dart';
import 'utils/todoapp_themes.dart';


//ok
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kprimarycolor, systemNavigationBarColor: kprimarycolor));
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
