import 'package:bestieku/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Supabase.initialize(
    url: "https://xcnggwwbpnvifejapdgq.supabase.co",
    anonKey: "sb_publishable_iSsvqMdwj1R9LijsNyj44g_4aZ3OsEY",
  );

  // Ambil client
  final supabase = Supabase.instance.client;

  // Ambil session TERBARU setelah inisialisasi selesai
  final session = supabase.auth.currentSession;

  // DEBUG: Cek di console apakah session terbaca
  if (session != null) {
    print("USER TERDETEKSI: ${session.user.email}");
  } else {
    print("USER TIDAK ADA (NULL)");
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: session == null ? Routes.SIGN_IN : AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.light,
    ),
  );
}
