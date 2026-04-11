class ProjectModel {
  int? id;
  String? name;
  String? description;
  String? color;
  DateTime? startDate;
  DateTime? endDate;
  int? userId;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.color,
    this.startDate,
    this.endDate,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    userId = json['user_id'];
  }
}
