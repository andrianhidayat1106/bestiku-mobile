import 'package:get/get.dart';

import '../controllers/detail_project_controller.dart';

class DetailProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProjectController>(
      () => DetailProjectController(),
    );
  }
}
