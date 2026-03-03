import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_daily_controller.dart';

class TaskDailyView extends GetView<TaskDailyController> {
  const TaskDailyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskDailyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TaskDailyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
