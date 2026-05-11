import 'package:bestieku/app/models/transaction_model.dart';
import 'package:bestieku/app/models/wallet_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TransactionProvider extends GetConnect {
  final _supabase = Supabase.instance.client;

  Future<void> createTransactionRpc(Map<String, dynamic> data) async {
    await _supabase.rpc("handle_transcation", params: data);
  }

  Future<void> deleteTransaction(int id) async {
    await _supabase.from("transaction").delete().eq("id", id);
  }

  Future<List<Map<String, dynamic>>> getAllTransaction() async {
    // Ambil waktu sekarang dalam UTC
    final now = DateTime.now().toUtc();

    // Buat range awal dan akhir hari dalam UTC
    final startOfDay = DateTime.utc(
      now.year,
      now.month,
      now.day,
      0,
      0,
      0,
    ).toIso8601String();
    final endOfDay = DateTime.utc(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
      999,
    ).toIso8601String();

    return await _supabase
        .from("transaction")
        .select('*, wallet (*)')
        .gte('created_at', startOfDay)
        .lte('created_at', endOfDay)
        .order('created_at', ascending: false);
  }

  Future<List<Map<String, dynamic>>> fetchTransactionsByRangeAndWallet(
    DateTime rangeStart,
    DateTime rangeEnd,
    WalletModel wallet,
  ) async {
    final String startDate = DateTime(
      rangeStart.year,
      rangeStart.month,
      rangeStart.day,
      0,
      0,
      0,
    ).toIso8601String();

    final String endDate = DateTime(
      rangeEnd.year,
      rangeEnd.month,
      rangeEnd.day,
      23, // Jam 11 malam
      59, // Menit 59
      59, //
    ).toIso8601String();
    print(startDate);
    print(endDate);
    try {
      var query = _supabase
          .from('transaction')
          .select('* ,wallet (*)')
          .gte('created_at', startDate) // Greater than or equal
          .lte('created_at', endDate);

      if (wallet.id != 0) {
        query = query.eq('wallet_id', wallet.id.toString());
      }
      final response = await query.order('created_at', ascending: false);
      return response;
    } catch (e) {
      return [];
    }
  }
}
