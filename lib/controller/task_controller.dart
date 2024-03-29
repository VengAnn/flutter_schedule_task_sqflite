import 'package:flutter_schedule_with_sqlite/database/db_helper.dart';
import 'package:flutter_schedule_with_sqlite/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  List<Task> taskList = [];

  // function pass task to dbHelper
  Future<int> addTask({Task? task}) async {
    return await DBHelper.dbInsert(task);
  }

  //get all the data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    print("task controller : $tasks");

    // the data tasks return is map we need convert to obj and loop each obj add it to taskList
    taskList.assignAll(tasks.map((e) => new Task.fromJson(e)).toList());
    update();
  }

  // delele tasks
  void delele(Task task) {
    DBHelper.delete(task);

    // delete ok refresh list agian
    getTasks();
  }

  // update tasks completed
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
