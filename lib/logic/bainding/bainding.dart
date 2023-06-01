import 'package:get/get.dart';

class MyBainding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => null);
  }
}
