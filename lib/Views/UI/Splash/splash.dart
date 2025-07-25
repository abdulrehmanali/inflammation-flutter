import 'package:anti_inflammatory_app/Controllers/authVm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Utils/colors.dart';
import '../../../Utils/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() async {
    Future.delayed(const Duration(seconds: 5), () async {
      final user =
          await Provider.of<AuthVm>(context, listen: false).getUserData();
      if (user != null && user.id.isNotEmpty) {
        Get.offNamed('/home');
      } else {
        Get.offNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo.png', height: 120), // Your logo here
            const SizedBox(height: 20),
            Text(
              'InflamEase',
              style: AppTextStyles.heading
                  .copyWith(color: AppColors.backgroundColor),
            ),
            const SizedBox(height: 10),
            Text(
              'Anti-Inflammatory App',
              style: AppTextStyles.subheading
                  .copyWith(color: AppColors.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
