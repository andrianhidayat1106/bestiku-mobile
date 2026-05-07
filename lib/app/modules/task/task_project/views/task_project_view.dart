import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/task_project_controller.dart';
import 'package:intl/intl.dart';

class TaskProjectView extends GetView<TaskProjectController> {
  TaskProjectView({super.key});

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
                        Get.back();
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
                    'Daftar Project',
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => ElevatedButton(
                                onPressed: () {
                                  controller.isDelete.toggle();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.isDelete.value
                                      ? Colors.red
                                      : AppColors.primary,
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                    left: 32,
                                    right: 32,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  "Hapus Project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  AddTaskProjectSheet(),
                                  isScrollControlled: true,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 16,
                                  left: 32,
                                  right: 32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                "Tambah Project",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Text(
                          "Daftar Project",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        Obx(() {
                          return GridView.builder(
                            padding: EdgeInsets.only(top: 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 1, // atur sesuai desain
                                ),

                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),

                            itemCount:
                                controller.taskController.listProject.length,
                            itemBuilder: (context, index) {
                              ProjectModel project =
                                  controller.taskController.listProject[index];
                              return Obx(
                                () => GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(
                                        Routes.DETAIL_PROJECT,
                                        arguments: project.id,
                                      )?.then(
                                        (value) => controller.getAllProject(),
                                      ),
                                  child: Container(
                                    padding: EdgeInsets.all(12),

                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: controller.taskController
                                          .listColor(project.color),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 0.2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${project.name}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        controller.isDelete.value
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  style: IconButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Latar belakang tombol jadi merah
                                                    foregroundColor: Colors
                                                        .white, // Warna icon jadi putih supaya kontras
                                                  ),
                                                  onPressed: () {
                                                    // Panggil fungsi hapus dari controller kamu
                                                    if (!controller
                                                        .isLoading
                                                        .value) {
                                                      controller.deleteProject(
                                                        project.id!,
                                                      );
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Progress 60%",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    child:
                                                        LinearProgressIndicator(
                                                          value: 0.6,
                                                          minHeight: 8,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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

class AddTaskProjectSheet extends GetView<TaskProjectController> {
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.7,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Tambah Project",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 12),

              Expanded(
                child: Form(
                  // key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Project"),
                      SizedBox(height: 4),
                      TextFormField(
                        controller: controller.nameController,
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
                      SizedBox(height: 8),
                      Text("Deskripsi"),
                      SizedBox(height: 4),
                      TextFormField(
                        controller: controller.descriptionController,
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
                        maxLines: 4,
                        // 2. Batasi input hanya angka (membutuhkan import 'package:flutter/services.dart')
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rentang Tanggal",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Container(
                                      width: Get.width * 0.9,
                                      child: CalendarView(),
                                    ),
                                  ),
                                ),
                              );
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
                      SizedBox(height: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Warna"),
                            SizedBox(height: 4),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectColor.value = "green";
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              // ignore: unrelated_type_equality_checks
                                              controller.selectColor.value ==
                                                  "green"
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: Color(0XFF34C759),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectColor.value = "blue";
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              // ignore: unrelated_type_equality_checks
                                              controller.selectColor.value ==
                                                  "blue"
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: Color(0XFF00C0E8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),

                                  GestureDetector(
                                    onTap: () {
                                      controller.selectColor.value = "brown";
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              // ignore: unrelated_type_equality_checks
                                              controller.selectColor.value ==
                                                  "brown"
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: Color.fromARGB(
                                          255,
                                          143,
                                          105,
                                          112,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectColor.value = "purple";
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              // ignore: unrelated_type_equality_checks
                                              controller.selectColor.value ==
                                                  "purple"
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: const Color.fromARGB(
                                          255,
                                          97,
                                          97,
                                          185,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectColor.value =
                                          "soft-green";
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              // ignore: unrelated_type_equality_checks
                                              controller.selectColor.value ==
                                                  "soft-green"
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        color: const Color.fromARGB(
                                          255,
                                          97,
                                          185,
                                          147,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,

                        child: Obx(() {
                          bool isLoading = controller.isLoading.value;
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
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {
                              if (!isLoading) {
                                controller.addTask();
                              }
                            },
                            child: Text("Tambah"),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  final TaskProjectController taskProjectController =
      Get.find<TaskProjectController>();
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
            focusedDay: taskProjectController.focusedDay.value,
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            rangeStartDay: taskProjectController.rangeStart.value,
            rangeEndDay: taskProjectController.rangeEnd.value,
            calendarFormat: taskProjectController.calendarFormat.value,
            rangeSelectionMode: RangeSelectionMode.enforced,
            onRangeSelected: taskProjectController.onRangeSelected,
            onFormatChanged: (format) =>
                taskProjectController.calendarFormat.value = format,
          );
        }),
      ),
    );
  }
}
