import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import '../controllers/task_list_controller.dart';

class TaskListView extends GetView<TaskListController> {
  TaskListView({super.key});

  final items = List.generate(30, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 16, right: 16),
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.primary,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Daftar Tugas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, top: 48, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rentang Tanggal",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(CalendarView());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 0.2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: AppColors.primary,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.rangeText, // dummy text
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          "Daftar Tugas",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: () {
                                    bool isDelete = controller.isDelete.value;
                                    if (isDelete) {
                                      controller.isDelete(false);
                                      return;
                                    }

                                    controller.isDelete(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: controller.isDelete.value
                                        ? Colors.red
                                        : AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,

                                      vertical: 16,
                                    ),
                                  ),
                                  child: Text("Hapus Tugas"),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(FormTaskView());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,

                                    vertical: 16,
                                  ),
                                ),
                                child: Text("Tambah Tugas"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Obx(() {
                          bool isDelete = controller.isDelete.value;
                          if (controller.taskController.listTask.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.post_add_rounded,
                                    color: AppColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    size: 48,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Belum ada tugas yang diinput",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Daftar tugas kamu masih kosong.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primary.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var task =
                                  controller.taskController.listTask[index];
                              return Container(
                                height: 80,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 0.2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.name,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    isDelete
                                        ? IconButton(
                                            style: IconButton.styleFrom(
                                              backgroundColor: Colors
                                                  .red, // Latar belakang tombol jadi merah
                                              foregroundColor: Colors
                                                  .white, // Warna icon jadi putih supaya kontras
                                            ),
                                            onPressed: () {
                                              // Panggil fungsi hapus dari controller kamu
                                              controller.deleteTask(task.id);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Checkbox(
                                            value: task.finishedAt == null
                                                ? false
                                                : true,
                                            onChanged: (value) {
                                              controller.taskController
                                                  .changeFinishedTask(index);
                                            },
                                          ),
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            separatorBuilder: (txt, index) =>
                                SizedBox(height: 12),
                            itemCount:
                                controller.taskController.listTask.length,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormTaskView extends StatelessWidget {
  final TaskListController taskListController = Get.put(TaskListController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.6,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Tambah Tugas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text("Nama Tugas"),
            SizedBox(height: 4),
            Expanded(
              child: Form(
                child: TextFormField(
                  controller: taskListController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama dompet tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                var isLoading = taskListController.isLoading.value;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  onPressed: () =>
                      isLoading ? null : taskListController.addTask(),
                  child: Text("Tambah"),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  final TaskListController taskListController = Get.put(TaskListController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.5,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Obx(() {
          return TableCalendar(
            focusedDay: taskListController.focusedDay.value,
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            rangeStartDay: taskListController.rangeStart.value,
            rangeEndDay: taskListController.rangeEnd.value,
            calendarFormat: taskListController.calendarFormat.value,
            rangeSelectionMode: RangeSelectionMode.enforced,
            onRangeSelected: taskListController.onRangeSelected,
            onFormatChanged: (format) =>
                taskListController.calendarFormat.value = format,
          );
        }),
      ),
    );
  }
}
