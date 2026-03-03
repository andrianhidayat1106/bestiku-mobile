import 'package:get/get.dart';

import '../controllers/task_daily_controller.dart';

class TaskDailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDailyController>(
      () => TaskDailyController(),
    );
  }
}
