import 'package:bestieku/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends GetxController {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await supabase.auth.signInWithPassword(
        email: "${emailC.text.trim()}@gmail.com",
        password: passwordC.text,
      );

      if (response.user != null) {
        Get.offAllNamed(Routes.WALLET);
      }
    } catch (e) {
      Get.snackbar(
        "",
        titleText: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.black87),
            SizedBox(width: 12),
            Text("Perhatian"),
          ],
        ),
        "Email atau Password anda salah",
        backgroundColor: Colors.amber,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
