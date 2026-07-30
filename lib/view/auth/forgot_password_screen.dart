import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/core/widgets/lable_text.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

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
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                textfoamlabel(
                  "Enter your email and we'll send you a link to reset your password",
                ),

                10.verticalSpace,

                textfoamlabel("EMAIL"),
                5.verticalSpace,
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                ),
                20.verticalSpace,
                Consumer<AuthViewModel>(
                  builder: (context, value, child) => CustomButton(
                    text: "SEND RESET LINK",
                    isloading: value.isLoading,
                    onPressed: () async {
                      try {
                        await value.forgotPassword(emailController.text.trim());
                        Get.back();
                        Get.snackbar(
                          "Success",
                          "Password reset link sent to your email",
                          colorText: Colors.white,
                        );
                      } catch (e) {
                        Get.snackbar(
                          "error",
                          e.toString(),
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                ),

                10.verticalSpace,
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: textfoamlabel("Back to Sign In"),
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
