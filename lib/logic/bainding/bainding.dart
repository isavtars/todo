import 'package:get/get.dart';

import '../themchanger.dart';

class MyBainding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemModeChange());
  }
}
