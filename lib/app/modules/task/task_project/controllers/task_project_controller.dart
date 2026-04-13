import 'package:bestieku/app/data/project_provider.dart';
import 'package:bestieku/app/modules/task/controllers/task_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TaskProjectController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var rangeStart = Rxn<DateTime>(DateTime.now());
  var rangeEnd = Rxn<DateTime>(DateTime.now());
  var calendarFormat = CalendarFormat.month.obs;
  var selectColor = "green".obs;
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var _projectProvider = ProjectProvider();
  var taskController = TaskController();
  var isDelete = false.obs;

  @override
  void onInit() {
    super.onInit();
    taskController.getAllProject();
  }

  void deleteProject(int id) {
    try {
      _projectProvider.deleteProject(id);
      taskController.getAllProject();
    } finally {}
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

  void addTask() {
    try {
      var data = {
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "color": selectColor.value,
        "start_date": rangeStart.value!.toIso8601String(),
        "end_date": rangeStart.value!.toIso8601String(),
      };
      _projectProvider.createProject(data);
      taskController.getAllProject();
      Get.back();
    } finally {}
  }
}
