import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/core/widgets/lable_text.dart';
import 'package:elitestate/view/Bottom_navigation/Bottombar.dart';

import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:elitestate/view_model/imagepicker_viewmodel.dart';
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

//

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
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
                  "Create your Account",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                textfoamlabel("Find,save,and tour homes that you love"),
                5.verticalSpace,
                textfoamlabel("Full NAME"),
                5.verticalSpace,

                CustomTextFormField(
                  controller: nameController,
                  hintText: "Full Name",
                  prefixIcon: Icons.person,
                ),
                5.verticalSpace,
                textfoamlabel("EMAIL"),
                5.verticalSpace,
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                ),
                5.verticalSpace,
                textfoamlabel("PASSWORD"),
                5.verticalSpace,
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),

                10.verticalSpace,
                CustomButton(
                  text: "CREATE ACCOUNT",
                  onPressed: () async {
                    try {
                      // ImagePickerViewModel access
                      final imageVM = context.read<ImagepickerViewmodel>();

                      // Profile image Cloudinary par upload
                      final String? profileImageUrl = await imageVM
                          .uploadProfileImage();
                      /////// signup////////
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
                    textfoamlabel("OR SIGN UP WITH"),
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
                      Get.back();
                    },
                    child: textfoamlabel("Already have an account? Sign In"),
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
