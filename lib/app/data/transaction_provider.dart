import 'package:bestieku/app/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TransactionProvider extends GetConnect {
  final _supabase = Supabase.instance.client;

  Future<void> createTransactionRpc(Map<String, dynamic> data) async {
    await _supabase.rpc("handle_transcation", params: data);
  }

  Future<List<Map<String, dynamic>>> getAllTransaction() async {
    final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return await _supabase
        .from("transaction")
        .select('* ,wallet (*)')
        .gte('created_at', '${todayDate}T00:00:00.000Z')
        .lte('created_at', '${todayDate}T23:59:59.999Z')
        .order('created_at', ascending: false);
  }
}
