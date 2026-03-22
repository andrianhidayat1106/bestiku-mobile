import 'package:bestieku/app/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionProvider extends GetConnect {
  final _supabase = Supabase.instance.client;

  Future<void> createTransactionRpc(Map<String, dynamic> data) async {
    await _supabase.from("transaction").insert(data);
  }
}
