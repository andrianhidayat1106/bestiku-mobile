class ProjectModel {
  int? id;
  String? name;
  String? description;
  String? color;
  DateTime? startDate;
  DateTime? endDate;

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
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
  }
  @override
  String toString() {
    return name ?? "";
  }
}
