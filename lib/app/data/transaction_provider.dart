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

  Future<List<Map<String, dynamic>>> getAllTransaction() async {
    final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return await _supabase
        .from("transaction")
        .select('* ,wallet (*)')
        // .gte('created_at', '${todayDate}T00:00:00.000Z')
        // .lte('created_at', '${todayDate}T23:59:59.999Z')
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
