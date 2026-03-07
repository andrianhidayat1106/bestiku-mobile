import 'package:get/get.dart';

import '../controllers/task_project_controller.dart';

class TaskProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskProjectController>(
      () => TaskProjectController(),
    );
  }
}
