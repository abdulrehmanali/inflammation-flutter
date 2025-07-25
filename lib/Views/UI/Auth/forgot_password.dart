import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                screenHeight, // Ensures the content fills the screen height
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  Text(
                    "Forgot Password?",
                    style: AppTextStyles.heading
                        .copyWith(fontSize: screenWidth * 0.08),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Enter your email address to reset your password.",
                    style: AppTextStyles.subheading
                        .copyWith(fontSize: screenWidth * 0.045),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                        // Set your custom color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.09),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded button corners
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      "Reset Password",
                      style: AppTextStyles.buttonText
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login'); // Navigate to Login Screen
                    },
                    child: Text(
                      "Back to Login",
                      style: AppTextStyles.normalText
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/Logo.png',
                        height: screenHeight * 0.1),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Extra space at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
