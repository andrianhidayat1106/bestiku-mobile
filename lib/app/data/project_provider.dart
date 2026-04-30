import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectProvider extends GetConnect {
  final _supabase = Supabase.instance.client;

  Future<void> createProject(Map<String, dynamic> data) async {
    await _supabase.from("project").insert(data);
  }

  Future<List<Map<String, dynamic>>> fetchAllProject() async {
    var data = await _supabase.from("project").select();
    return data;
  }

  Future<List<Map<String, dynamic>>> fetchAllProjectByDate(
    DateTime dateTime,
  ) async {
    DateTime startOfDay = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      0,
      0,
      0,
    );

    DateTime endOfDay = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      23,
      59,
      59,
    );

    var data = await _supabase
        .from("project")
        .select()
        .lte(
          "start_date",
          endOfDay.toIso8601String(),
        ) // Start date harus sebelum akhir hari ini
        .gte(
          "end_date",
          startOfDay.toIso8601String(),
        ); // End date harus setelah awal hari ini

    return data;
  }

  Future<void> deleteProject(int id) async {
    await _supabase.from("project").delete().eq("id", id);
  }

  Future<Map<String, dynamic>> fetchProjectById(int id) async {
    var data = await _supabase.from("project").select().eq("id", id).single();
    return data;
  }

  Future<void> update(int id, Map<String, dynamic> data) async {
    await _supabase.from("project").update(data).eq("id", id);
  }
}
