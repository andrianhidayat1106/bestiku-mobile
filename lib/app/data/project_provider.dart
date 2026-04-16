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

  Future<void> deleteProject(int id) async {
    await _supabase.from("project").delete().eq("id", id);
  }

  Future<Map<String, dynamic>> fetchProjectById(int id) async {
    var data = await _supabase.from("project").select().eq("id", id).single();
    return data;
  }
}
