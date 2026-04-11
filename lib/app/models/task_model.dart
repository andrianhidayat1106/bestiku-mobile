import 'package:bestieku/app/models/project_model.dart';

class TaskModel {
  int? id;
  String? name;
  DateTime? finishedAt;
  ProjectModel? project;
  DateTime? startDate;
  DateTime? endDate;

  TaskModel({
    this.id,
    this.name,
    this.finishedAt,
    this.project,
    this.startDate,
    this.endDate,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];

    finishedAt = json["finished_at"] != null
        ? DateTime.tryParse(json["finished_at"])
        : null;

    // Parsing Nested Object (ProjectModel)
    project = json["project"] != null
        ? ProjectModel.fromJson(json["project"])
        : null;

    startDate = json["start_date"] != null
        ? DateTime.tryParse(json["start_date"])
        : null;

    endDate = json["end_date"] != null
        ? DateTime.tryParse(json["end_date"])
        : null;
  }
}
