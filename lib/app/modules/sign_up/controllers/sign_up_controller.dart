import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  final isLoading = false.obs;

  Future<void> signUp() async {
    // validate Password

    if (!formKey.currentState!.validate()) {
      return;
    }
    if (passwordC.text != confirmPasswordC.text) {
      Get.snackbar(
        "",
        titleText: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.black87),
            SizedBox(width: 12),
            Text("Perhatian"),
          ],
        ),
        "Konfirmasi password tidak cocok dengan password utama",
        backgroundColor: Colors.amber,
      );
      return;
    }
    try {
      isLoading.value = true;

      final response = await supabase.auth.signUp(
        password: passwordC.text,
        email: "${emailC.text.trim()}@gmail.com",
        data: {'full_name': nameC.text},
      );

      if (response.user != null) {
        Get.snackbar("Sukses", "Pendaftaran berhasil!");
        Get.offAllNamed(Routes.WALLET);
      }
    } catch (e) {
      Get.snackbar("Error", "e");
    } finally {
      isLoading.value = false;
    }
  }
}
