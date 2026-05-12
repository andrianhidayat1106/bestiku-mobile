import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/data/project_provider.dart';
import 'package:bestieku/app/data/task_provider.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:bestieku/app/models/task_model.dart';
import 'package:bestieku/utils/snackbar_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskController extends GetxController {
  final _taskProvider = TaskProvider();
  final _projectProvider = ProjectProvider();
  var listTask = [].obs;
  var listProject = [].obs;
  var focusedDay = DateTime.now().obs;
  var selectDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;
  var selectProject = Rxn<ProjectModel>();
  var totalSelesaiHarian = 0.obs;
  var totalSelesaiProject = 0.obs;
  var isLoadingInitialData = false.obs;
  var isLoading = false.obs;

  void onDaySelected(DateTime select, DateTime focused) {
    focusedDay.value = focused;
    selectDay.value = select;

    getAllProjectByDay();
    getAllTaskByDay();
    refreshAmount();
  }

  @override
  void onInit() {
    getAllTaskByDay();
    getAllProjectByDay();
    refreshAmount();
    super.onInit();
  }

  List get completedTasks =>
      listTask.where((task) => task.finishedAt != null).toList();

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

  Future<void> getAllProjectByDay() async {
    try {
      var res = await _projectProvider.fetchAllProjectByDate(focusedDay.value);
      var data = res.map((e) => ProjectModel.fromJson(e)).toList();
      listProject.assignAll(data);
    } catch (e) {
      Get.closeAllSnackbars(); // Bersihkan snackbar lama
      AppSnackbar.error("Gagal mengambil data proyek");
    }
  }

  Future<void> refreshAmount() async {
    try {
      final results = await Future.wait([
        getAllAmountTask(),
        getAllAmountTaskByProjectId(),
      ]);

      totalSelesaiHarian.value = results[0];
      totalSelesaiProject.value = results[1];
    } catch (e) {
      print("Error refresh amount: $e");
    }
  }

  Future<int> getAllAmountTask() async {
    var res = await _taskProvider.fetchAllTaskByDay(selectDay.value);
    List<TaskModel> localTasks = res.map((e) => TaskModel.fromJson(e)).toList();
    return localTasks
        .where((task) => task.finishedAt != null && task.project == null)
        .length;
  }

  Future<void> getAllTaskByProjectId() async {
    try {
      int id = selectProject.value!.id!;
      var res = await _taskProvider.fetchAllTaskByProjectId(id);
      var data = res.map((e) => TaskModel.fromJson(e)).toList();
      listTask.assignAll(data);
    } catch (e) {
      Get.closeAllSnackbars();
      AppSnackbar.error("Gagal memuat tugas proyek");
    }
  }

  Future<int> getAllAmountTaskByProjectId() async {
    var res = await _taskProvider.fetchAllTaskByDay(selectDay.value);
    List<TaskModel> tasks = res.map((e) => TaskModel.fromJson(e)).toList();
    return tasks
        .where((task) => task.finishedAt != null && task.project != null)
        .length;
  }

  Future<void> getAllTaskByDay() async {
    try {
      var res = await _taskProvider.fetchTaskByDay(selectDay.value);
      var data = res.map((e) => TaskModel.fromJson(e)).toList();
      listTask.assignAll(data);
    } catch (e) {
      Get.closeAllSnackbars();
      AppSnackbar.error("Gagal mengambil daftar tugas");
    }
  }

  Future<void> changeFinishedTask(int index) async {
    final DateTime? originalStatus = listTask[index].finishedAt;

    // Tampilkan Loading Dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      barrierDismissible: false,
    );

    try {
      DateTime? updatedTime = originalStatus == null ? DateTime.now() : null;

      // Update UI Lokal
      listTask[index].finishedAt = updatedTime;
      listTask.refresh();

      // Simpan ke database
      await _taskProvider.onTaskChanged(updatedTime, listTask[index].id);

      // Tutup Dialog
      if (Get.isDialogOpen ?? false) Get.back();

      // Update angka dashboard
      refreshAmount();

      // Tutup snackbar lama sebelum menampilkan yang baru
      Get.closeAllSnackbars();
      AppSnackbar.success(
        updatedTime == null ? "Tugas dibatalkan" : "Tugas selesai!",
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();

      // Rollback UI
      listTask[index].finishedAt = originalStatus;
      listTask.refresh();

      Get.closeAllSnackbars();
      AppSnackbar.error("Gagal memperbarui tugas");
    }
  }
}
