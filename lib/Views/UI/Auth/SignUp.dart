import 'package:anti_inflammatory_app/Controllers/authVm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Utils/toast.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isRememberMe = false;

  final RxBool isPasswordVisible = false.obs;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Consumer<AuthVm>(builder: (context, p, child) {
          return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screenHeight * 0.08),
                        Text(
                          "Hello!",
                          style: AppTextStyles.heading
                              .copyWith(fontSize: screenWidth * 0.08),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "We are glad you are here, link your mail to start.",
                          style: AppTextStyles.subheading
                              .copyWith(fontSize: screenWidth * 0.045),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        TextField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Obx(() => TextField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible.value,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    isPasswordVisible.value =
                                        !isPasswordVisible.value;
                                  },
                                ),
                              ),
                            )),
                        SizedBox(height: screenHeight * 0.02),
                        CheckboxListTile(
                          title: const Text("Remember me"),
                          value: isRememberMe,
                          onChanged: (newValue) {
                            isRememberMe = !isRememberMe;
                            setState(() {});
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppColors.primaryColor,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              p.isLoading
                                  ? const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: CircularProgressIndicator
                                              .adaptive(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  strokeWidth: 2)))
                                  : ElevatedButton(
                                      onPressed: () async {
                                        if (emailController.text.isEmpty) {
                                          snackBarColorF(
                                              "Email Is Required", context);
                                          return;
                                        } else if (passwordController
                                            .text.isEmpty) {
                                          snackBarColorF(
                                              "Password Is Required", context);
                                          return;
                                        } else if (fullNameController
                                            .text.isEmpty) {
                                          snackBarColorF(
                                              "Name Is Required", context);
                                          return;
                                        }
                                        await p.signup(context,
                                            name: fullNameController.text,
                                            email: emailController.text,
                                            password: passwordController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.08,
                                              vertical: screenHeight * 0.02)),
                                      child: Text("Sign up",
                                          style: AppTextStyles.buttonText
                                              .copyWith(color: Colors.white))),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/login');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.08,
                                          vertical: screenHeight * 0.02)),
                                  child: Text("Log in",
                                      style: AppTextStyles.buttonText
                                          .copyWith(color: Colors.white)))
                            ]),
                        SizedBox(height: screenHeight * 0.04),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Link email to start",
                                style: AppTextStyles.normalText)),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot_password');
                            },
                            child: Text("Forgot your password?",
                                style: AppTextStyles.normalText
                                    .copyWith(color: AppColors.accentColor))),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/Logo.png',
                                height: screenHeight * 0.1))
                      ])));
        }));
  }
}
