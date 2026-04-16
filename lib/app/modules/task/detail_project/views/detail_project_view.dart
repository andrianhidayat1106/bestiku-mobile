import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/detail_project_controller.dart';

class DetailProjectView extends GetView<DetailProjectController> {
  DetailProjectView({super.key});

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
                    'Detail Project',
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
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Project",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: controller.nameController,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Deskripsi",

                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                maxLines: 4,
                                controller: controller.description,
                              ),
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
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
                                              controller
                                                  .rangeText, // dummy text
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
                                "Warna",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Daftar Tugas",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                              child: Text("Tambah Tugas"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Obx(
                          () => ReorderableListView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Mematikan scroll internal list
                            buildDefaultDragHandles:
                                false, // Wajib false karena kita pakai icon titik 6
                            // Memberikan feedback visual saat item diangkat agar tidak error layout
                            proxyDecorator: (child, index, animation) {
                              return Material(
                                type: MaterialType.transparency,
                                elevation: 5,
                                child: child,
                              );
                            },
                            itemBuilder: (context, index) {
                              final task = controller.taskProjectDetail[index];
                              return Padding(
                                key: ValueKey(task),
                                padding: EdgeInsetsGeometry.only(bottom: 12),
                                child: Container(
                                  height: 80,
                                  padding: EdgeInsetsGeometry.only(right: 16),
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
                                      ReorderableDragStartListener(
                                        index: index,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Icon(
                                            Icons.drag_indicator,
                                            size: 30,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Belajar Mobile Flutter",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Tugas Bahasa Inggris",
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Checkbox(
                                        value: false,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.taskProjectDetail.length,
                            onReorder: controller.reorderTask,
                          ),
                        ),
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

class CalendarView extends StatelessWidget {
  final DetailProjectController detailProjectController = Get.put(
    DetailProjectController(),
  );
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
        child: Obx(() {
          return TableCalendar(
            focusedDay: detailProjectController.focusedDay.value,
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            rangeStartDay: detailProjectController.rangeStart.value,
            rangeEndDay: detailProjectController.rangeEnd.value,
            calendarFormat: detailProjectController.calendarFormat.value,
            rangeSelectionMode: RangeSelectionMode.enforced,
            onRangeSelected: detailProjectController.onRangeSelected,
            onFormatChanged: (format) =>
                detailProjectController.calendarFormat.value = format,
          );
        }),
      ),
    );
  }
}
