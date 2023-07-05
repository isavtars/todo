import 'package:get/get.dart';

import '../models/task_models.dart';
import '../resources/sql_lite_helper.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  var taskbyid = <Task>[].obs;
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

//delete by id
  deleteTask(Task task) {
    return SQLHelper.deleteItem(task);
  }

  //getitem by id;
  getTasksById(Task task) async {
    List<Map<String, dynamic>> taskis = await SQLHelper.getItem(task);
    // reactive managers toassigned to list
    taskbyid.assignAll(taskis.map((data) => Task.fromJson(data)).toList());
  }

  makeTaskCompleted(int id) {
    return SQLHelper.updateCompleted(id);
  }
}
