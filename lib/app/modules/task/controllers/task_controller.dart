import 'package:bestieku/app/data/project_provider.dart';
import 'package:bestieku/app/data/task_provider.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:bestieku/app/models/task_model.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final _taskProvider = TaskProvider();
  final _projectProvider = ProjectProvider();
  var listTask = [].obs;
  var listProject = [].obs;

  @override
  void onInit() {
    getAllTask();
    getAllProject();
    super.onInit();
  }

  Future<void> getAllProject() async {
    var res = await _projectProvider.fetchAllProject();
    var data = res.map((e) => ProjectModel.fromJson(e)).toList();
    listProject.assignAll(data);
  }

  Color listColor(String? value) {
    switch (value) {
      case 'brown':
        return const Color.fromARGB(255, 143, 105, 112);
      case 'blue':
        return const Color(0XFF00C0E8);
      case 'green':
        return const Color(0XFF34C759);
      case 'purple':
        return const Color.fromARGB(255, 97, 97, 185);
      case 'soft-green':
        return const Color.fromARGB(255, 97, 185, 147);
      default:
        return const Color(0XFF34C759);
    }
  }

  Future<void> getAllTask() async {
    var res = await _taskProvider.fetchAllTask();
    var data = res.map((e) => TaskModel.fromJson(e)).toList();
    listTask.assignAll(data);
  }

  void changeFinishedTask(int index) async {
    DateTime? updatedTime = listTask[index].finishedAt == null
        ? DateTime.now()
        : null;
    listTask[index].finishedAt = updatedTime;

    listTask.refresh();
    await _taskProvider.onTaskChanged(updatedTime, listTask[index].id);
  }
}
