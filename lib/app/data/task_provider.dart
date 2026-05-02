import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskProvider extends GetConnect {
  var _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchAllTask() async {
    var res = _supabase
        .from("task")
        .select()
        .filter("project_id", "is", null)
        .order('finished_at', ascending: false, nullsFirst: true);
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchTaskByDay(DateTime dateTime) async {
    // Format tanggal menjadi YYYY-MM-DD
    String dateIso =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    final res = await _supabase
        .from("task")
        .select()
        .filter("project_id", "is", null)
        // Mengambil task yang rentang waktunya aktif di tanggal tersebut
        .lte("start_date", dateIso)
        .gte("end_date", dateIso)
        .order('finished_at', ascending: false, nullsFirst: true);

    return res;
  }

  Future<List<Map<String, dynamic>>> fetchAllTaskByDay(
    DateTime dateTime,
  ) async {
    // Format tanggal menjadi YYYY-MM-DD
    String dateIso =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    final res = await _supabase
        .from("task")
        .select('*, project(*)') // Ambil semua kolom task DAN data project-nya
        // Filter project_id dihapus agar semua task (baik yang punya project_id maupun null) ikut terambil
        .lte("start_date", dateIso)
        .gte("end_date", dateIso)
        .order('finished_at', ascending: false, nullsFirst: true);

    return res;
  }

  Future<void> createTask(Map<String, dynamic> data) async {
    await _supabase.from("task").insert(data);
  }

  Future<void> onTaskChanged(DateTime? dateTime, int id) async {
    await _supabase
        .from("task")
        .update({"finished_at": dateTime?.toIso8601String()})
        .eq("id", id);
  }

  Future<void> deleteTask(int id) async {
    await _supabase.from("task").delete().eq("id", id);
  }

  Future<List<Map<String, dynamic>>> fetchAllTaskByProjectId(int id) async {
    var res = _supabase
        .from("task")
        .select("*,project(*)")
        .eq("project_id", id)
        .order('finished_at', ascending: false, nullsFirst: true);

    return res;
  }
}
