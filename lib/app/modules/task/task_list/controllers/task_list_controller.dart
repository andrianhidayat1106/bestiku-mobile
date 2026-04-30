import 'package:bestieku/app/data/task_provider.dart';
import 'package:bestieku/app/models/task_model.dart';
import 'package:bestieku/app/modules/task/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TaskListController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var rangeStart = Rxn<DateTime>(DateTime.now());
  var rangeEnd = Rxn<DateTime>(DateTime.now());
  var calendarFormat = CalendarFormat.month.obs;
  var isDelete = false.obs;
  var nameController = TextEditingController();
  final _taskProvider = TaskProvider();
  final taskController = TaskController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllTask();
    DateTime now = DateTime.now();

    rangeStart = Rxn<DateTime>(DateTime(now.year, now.month, now.day, 0, 0, 0));
    rangeEnd = Rxn<DateTime>(
      DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
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

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focused) {
    rangeStart.value = start;
    rangeEnd.value = end;
    focusedDay.value = focused;
    // getTransaction();
  }

  Future<void> getAllTask() async {
    var res = await _taskProvider.fetchAllTask();
    var data = res.map((e) => TaskModel.fromJson(e)).toList();
    taskController.listTask.assignAll(data);
  }

  Future<void> addTask() async {
    final Map<String, dynamic> data = {
      'name': nameController.text.trim(),
      'start_date': rangeStart.value!.toIso8601String(),
      'end_date': rangeEnd.value!.toIso8601String(),
    };
    try {
      isLoading(true);
      await _taskProvider.createTask(data);
      getAllTask();
      nameController.clear();
      Get.back();
    } finally {
      isLoading(false);
    }
  }

  void deleteTask(int id) async {
    await _taskProvider.deleteTask(id);
    getAllTask();
  }
}
