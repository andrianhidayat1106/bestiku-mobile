import 'package:bestieku/app/data/project_provider.dart';
import 'package:bestieku/app/data/task_provider.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:bestieku/app/models/task_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailProjectController extends GetxController {
  var project = ProjectModel().obs;
  var _projectProvider = ProjectProvider();
  var _taskProvider = TaskProvider();
  var projectId = 0.obs;
  var nameController = TextEditingController();
  var nameTaskController = TextEditingController();
  var descriptionController = TextEditingController();
  var focusedDay = DateTime.now().obs;
  var rangeStart = Rxn<DateTime>(DateTime.now());
  var rangeEnd = Rxn<DateTime>(DateTime.now());
  var calendarFormat = CalendarFormat.month.obs;
  var selectColor = "green".obs;
  var isDelete = false.obs;
  var listTaskProject = <TaskModel>[].obs;

  void reorderTask(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = listTaskProject.removeAt(oldIndex);
    listTaskProject.insert(newIndex, item);
  }

  @override
  void onInit() {
    projectId.value = Get.arguments;
    if (projectId.value != 0) {
      getProjectById(projectId.value);
    }
    getTaskByProjectId(projectId.value);
    super.onInit();
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focused) {
    rangeStart.value = start;
    rangeEnd.value = end;
    focusedDay.value = focused;
  }

  String get rangeText {
    if (rangeStart.value == null) return "Pilih tanggal";

    DateFormat formatter = DateFormat("dd/MM/yyyy");
    String start = formatter.format(rangeStart.value ?? DateTime.now());

    String end = rangeEnd.value != null
        ? formatter.format(rangeEnd.value!)
        : start;

    return "$start - $end";
  }

  Future<void> getProjectById(int id) async {
    var data = await _projectProvider.fetchProjectById(id);
    var projectData = ProjectModel.fromJson(data);
    project.value = projectData;

    nameController.text = projectData.name.toString();
    descriptionController.text = projectData.description.toString();

    rangeStart.value = projectData.startDate;
    rangeEnd.value = projectData.endDate;

    selectColor.value = projectData.color.toString();
  }

  Future<void> editProject() async {
    if (project.value.id == null) return;

    bool isChanged =
        nameController.text != project.value.name ||
        descriptionController.text != project.value.description ||
        rangeStart.value != project.value.startDate ||
        rangeEnd.value != project.value.endDate ||
        selectColor.value != project.value.color;

    if (isChanged) {
      var data = {
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "color": selectColor.value,
        "start_date": rangeStart.value!.toIso8601String(),
        "end_date": rangeEnd.value!.toIso8601String(),
      };
      await _projectProvider.update(projectId.value, data);
    }
  }

  Future<void> addTask() async {
    final Map<String, dynamic> data = {
      'name': nameTaskController.text.trim(),
      'start_date': rangeStart.value!.toIso8601String(),
      'end_date': rangeEnd.value!.toIso8601String(),
      'project_id': projectId.value,
    };
    try {
      // isLoading(true);
      await _taskProvider.createTask(data);
      // _taskProvider.getAllTask();
      getTaskByProjectId(projectId.value);
      nameTaskController.clear();
      Get.back();
    } finally {
      // isLoading(false);
    }
  }

  void changeFinishedTask(int index) async {
    DateTime? updatedTime = listTaskProject[index].finishedAt == null
        ? DateTime.now()
        : null;
    listTaskProject[index].finishedAt = updatedTime;

    listTaskProject.refresh();

    final taskId = listTaskProject[index].id;

    if (taskId != null) {
      await _taskProvider.onTaskChanged(updatedTime, taskId);
    } else {
      Get.snackbar("Error", "ID Task tidak ditemukan");
    }
  }

  void deleteTask(int id) async {
    await _taskProvider.deleteTask(id);
    getTaskByProjectId(projectId.value);
  }

  Future<void> getTaskByProjectId(int id) async {
    try {
      var data = await _taskProvider.fetchAllTaskByProjectId(id);
      listTaskProject.value = data.map((e) => TaskModel.fromJson(e)).toList();
    } finally {}
  }
}
