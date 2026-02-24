import 'package:bestieku/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Center(child: Text("- Masuk ke akun Anda -")),
              SizedBox(height: 24),
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
              SizedBox(height: 4),
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Text(
                  "Lupa password?",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary.withValues(alpha: 0.7),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 49,
                child: ElevatedButton(onPressed: () {}, child: Text("Masuk")),
              ),
              const Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Belum punya akun? ",
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
