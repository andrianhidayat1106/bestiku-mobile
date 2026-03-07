import 'package:get/get.dart';

class DetailProjectController extends GetxController {
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
}
