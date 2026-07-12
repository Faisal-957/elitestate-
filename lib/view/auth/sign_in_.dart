import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/view/Bottom_navigation/Bottombar.dart';
import 'package:elitestate/view/auth/registed_screen.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/logo3.png", scale: 2)),
                Text(
                  "Log in to your Account",
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 15.sp, color: golden),
                    ),
                  ),
                ),

                10.verticalSpace,
                CustomButton(
                  text: "LOG IN",
                  onPressed: () async {
                    try {
                      await context.read<AuthViewModel>().loginn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                      Get.to(() => BottomNavScreen());
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
                      icon: Image.asset("assets/images/google.png", scale: 15),
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
                      Get.to(() => const RegisterScreen());
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(fontSize: 15.sp, color: golden),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
