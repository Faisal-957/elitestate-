import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/view/auth/sign_in_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LogoutBottomSheet {
  // Show Bottom Sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(30),
          height: 300,
          decoration: BoxDecoration(
            color: lightBlack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),

          width: double.infinity,
          child: Column(
            children: [
              Icon(Icons.logout_rounded, color: golden, size: 36),
              12.verticalSpace,
              Text("Logout", style: style24.copyWith(color: whiteColor)),
              20.verticalSpace,

              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Are you sure you want to logout from \nthe app",
                  style: style16.copyWith(
                    color: whiteColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Logout Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context),

                    style: FilledButton.styleFrom(
                      backgroundColor: blackColor,
                      minimumSize: Size(149, 39),
                    ),
                    child: Text(
                      "Cancel",
                      style: style16.copyWith(color: whiteColor),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: darkpink),
                      minimumSize: Size(149, 39),
                    ),

                    onPressed: () async {
                      await FirebaseAuth.instance.signOut(); // 🔥 REAL LOGOUT

                      Get.back(); // bottom sheet close

                      Get.offAll(() => Signin()); // login/signup tabs screen
                    },

                    child: Text(
                      "Yes, Logout",
                      style: TextStyle(color: darkpink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Popup Function
}
