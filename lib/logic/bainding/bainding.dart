import 'package:get/get.dart';

import '../task_controller.dart';
import '../themchanger.dart';

class MyBainding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemModeChange());
    Get.put(TaskController());
  }
}
