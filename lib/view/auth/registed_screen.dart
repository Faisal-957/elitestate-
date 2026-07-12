import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/view/Bottom_navigation/Bottombar.dart';
import 'package:elitestate/view/home/home.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset("assets/images/logo3.png", scale: 2),
                  ),
                  Text(
                    "Create your Account",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Find,save,and tour homes that you love",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                  10.verticalSpace,
                  Text(
                    "FULL NAME ",
                    style: TextStyle(fontSize: 15.sp, color: golden),
                  ),
                  10.verticalSpace,

                  CustomTextFormField(
                    controller: nameController,
                    hintText: "Full Name",
                    prefixIcon: Icons.person,
                  ),
                  10.verticalSpace,
                  Text(
                    "EMAIL ADDRESS ",
                    style: TextStyle(fontSize: 15.sp, color: golden),
                  ),
                  10.verticalSpace,
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  10.verticalSpace,
                  Text(
                    "PASSWORD ",
                    style: TextStyle(fontSize: 15.sp, color: golden),
                  ),
                  10.verticalSpace,
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),

                  30.verticalSpace,
                  CustomButton(
                    text: "CREATE ACCOUNT",
                    onPressed: () async {
                      try {
                        await context.read<AuthViewModel>().signup(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        Get.to(BottomNavScreen());
                      } catch (e) {
                        Get.snackbar(
                          "error",
                          e.toString(),
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "OR SIGN UP WITH",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/google.png",
                          scale: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/images/facebook.png",
                          scale: 15,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(fontSize: 15.sp, color: golden),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
