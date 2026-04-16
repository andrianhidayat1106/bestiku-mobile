import 'package:bestieku/app/data/project_provider.dart';
import 'package:bestieku/app/models/project_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailProjectController extends GetxController {
  var project = ProjectModel().obs;
  var _projectProvider = ProjectProvider();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var focusedDay = DateTime.now().obs;
  var rangeStart = Rxn<DateTime>(DateTime.now());
  var rangeEnd = Rxn<DateTime>(DateTime.now());
  var calendarFormat = CalendarFormat.month.obs;
  var selectColor = "green".obs;
  var description = TextEditingController();

  var taskProjectDetail = <String>[
    "Belajar Flutter",
    "React Web ",
    "asas",
    "assdasdd",
  ].obs;

  void reorderTask(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = taskProjectDetail.removeAt(oldIndex);
    taskProjectDetail.insert(newIndex, item);
  }

  @override
  void onInit() {
    getProjectById(Get.arguments);
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
    description.text = projectData.description.toString();

    rangeStart.value = projectData.startDate;
    rangeEnd.value = projectData.endDate;

    selectColor.value = projectData.color.toString();
  }
}
