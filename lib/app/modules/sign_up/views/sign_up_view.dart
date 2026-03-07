import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:bestieku/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 64),
              SvgPicture.asset(
                "assets/images/logo.svg",
                width: 190,
                height: 190,
              ),
              Center(child: Text("- Daftar ke akun Anda -")),
              SizedBox(height: 24),

              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: controller.nameC,
                      decoration: InputDecoration(
                        hintText: "Nama lengkap",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Nama lengkap wajib diisi.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: controller.emailC,
                      decoration: InputDecoration(
                        hintText: "contoh: andrianhidayat1106",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixText: "@gmail.com",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Alamat email wajib diisi.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),

                    Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordC,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password wajib diisi.";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 8),
                    Text(
                      "Konfirmasi Password ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: controller.confirmPasswordC,

                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0.8, fontSize: 11),
                        hintText: "Konfirmasi Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Konfirmasi Password wajib diisi.";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      height: 49,
                      child: Obx(() {
                        bool loading = controller.isLoading.value;
                        return ElevatedButton(
                          onPressed: () => loading ? null : controller.signUp(),
                          child: Text("Buat"),
                        );
                      }),
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Sudah punya akun? ",
                          style: TextStyle(
                            color: Colors.black, // 🔥 warna bisa kamu set
                          ),
                          children: [
                            TextSpan(
                              text: "Masuk",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors.primary, // 🔥 warna bisa kamu set
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.SIGN_IN);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
