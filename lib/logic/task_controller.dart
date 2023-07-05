import 'package:get/get.dart';

import '../models/task_models.dart';
import '../resources/sql_lite_helper.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
//add to task
  Future<int> addToTask({required Task task}) {
    return SQLHelper.createTask(task);
  }

  //getTasks from users
  getTasks() async {
    List<Map<String, dynamic>> task = await SQLHelper.getItems();
    // reactive managers toassigned to list
    taskList.assignAll(task.map((data) => Task.fromJson(data)).toList());
  }
}
