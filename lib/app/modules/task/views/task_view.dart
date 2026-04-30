import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tugas hari ini!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  DateFormat(
                                    'EEEE, d MMM yyyy',
                                    'id_ID',
                                  ).format(controller.selectDay.value),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
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
                          icon: SvgPicture.asset(
                            "assets/images/icons/calender.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Total Tugas Selesai",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          width: 170,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Tugas Harian Selesai",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                    fontSize: 44,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          width: 170,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.lightOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Tugas Harian Project",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 44,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    InkWell(
                      onTap: () => Get.toNamed(
                        Routes.TASK_PROJECT,
                      )?.then((value) => controller.getAllProjectByDay()),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_right,
                            color: AppColors
                                .primary, // Warna abu-abu agar tidak terlalu mencolok
                            size: 25,
                          ),
                          Text(
                            "Tugas Project",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    SizedBox(
                      height: 160,

                      child: Obx(() {
                        if (controller.listProject.isEmpty) {
                          return const Center(
                            child: Text("No projects available"),
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            ProjectModel project =
                                controller.listProject[index];
                            return GestureDetector(
                              onTap: () =>
                                  Get.toNamed(
                                    Routes.DETAIL_PROJECT,
                                    arguments: project.id,
                                  )?.then((value) {
                                    controller.getAllProjectByDay();
                                  }),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: controller.listColor(project.color),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 0.2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Progress 80%",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: 0.8,
                                            minHeight: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10),

                          itemCount: controller.listProject.length,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    InkWell(
                      onTap: () => Get.toNamed(
                        Routes.TASK_LIST,
                      )?.then((value) => controller.getAllProjectByDay()),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_right,
                            color: AppColors
                                .primary, // Warna abu-abu agar tidak terlalu mencolok
                            size: 25,
                          ),
                          Text(
                            "Daftar Tugas",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var task = controller.listTask[index];
                          return Container(
                            height: 80,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.2),
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
                                Checkbox(
                                  value: task.finishedAt == null ? false : true,
                                  onChanged: (value) {
                                    controller.changeFinishedTask(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        separatorBuilder: (txt, index) => SizedBox(height: 12),
                        itemCount: controller.listTask.length,
                      );
                    }),
                  ],
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
  final TaskController taskController = Get.find<TaskController>();
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
            focusedDay: taskController.focusedDay.value,
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            calendarFormat: taskController.calendarFormat.value,
            selectedDayPredicate: (day) {
              return isSameDay(taskController.selectDay.value, day);
            },
            onDaySelected: taskController.onDaySelected,
            onFormatChanged: (format) =>
                taskController.calendarFormat.value = format,
          );
        }),
      ),
    );
  }
}
