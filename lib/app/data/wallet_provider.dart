import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletProvider extends GetConnect {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getWallet() async {
    final data = await _supabase
        .from("wallet")
        .select()
        .order('created_at', ascending: false);
    return data;
  }

  Future<void> createWallet(Map<String, dynamic> data) async {
    await _supabase.from("wallet").insert(data);
  }

  Future<void> updateWallet(int id, Map<String, dynamic> data) async {
    await _supabase.from("wallet").update(data).eq("id", id);
  }

  Future<void> deleteWallet(int id) async {
    await _supabase.from("wallet").delete().eq("id", id);
  }
}
