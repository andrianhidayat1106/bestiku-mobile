import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 16, right: 16),
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
              Text(
                "Nama Lengkap",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Nama Lengkap",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
              TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Text(
                "Konfirmasi Password",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Konfirmasi Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 20),
              SizedBox(
                height: 49,
                child: ElevatedButton(onPressed: () {}, child: Text("Buat")),
              ),
              const Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Sudah punya akun? ",
                    style: TextStyle(
                      color: Colors.black, // 🔥 warna bisa kamu set
                    ),
                    children: [
                      TextSpan(
                        text: "Daftar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, // 🔥 warna bisa kamu set
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
