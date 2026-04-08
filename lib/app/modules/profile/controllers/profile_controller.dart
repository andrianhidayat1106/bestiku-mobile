import 'package:bestieku/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;
  User? get currentUser => _supabase.auth.currentUser;

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      Get.offAllNamed(Routes.SIGN_IN);
    } catch (e) {
      Get.snackbar("Error", "Gagal logout: $e");
    }
  }
}
