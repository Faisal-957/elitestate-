import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isDanger;
  final VoidCallback onTap;

  const MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isDanger ? darkpink : golden;

    return Material(
      color: lightBlack,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: style16.copyWith(
                        color: isDanger ? darkpink : whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      2.verticalSpace,
                      Text(
                        subtitle!,
                        style: style12.copyWith(
                          color: whiteColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: whiteColor.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///// profile screen upper section //
Widget buildHeader(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
        height: 190,
        width: double.infinity,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
        padding: const EdgeInsets.only(top: 55),
        child: Consumer<AuthViewModel>(
          builder: (context, vm, child) {
            final email = vm.userEmail.isNotEmpty
                ? vm.userEmail
                : (FirebaseAuth.instance.currentUser?.email ?? "");
            return Column(
              children: [
                Text(
                  vm.userName.isNotEmpty ? vm.userName : "Guest",
                  style: style24.copyWith(color: whiteColor),
                ),
                6.verticalSpace,
                Text(
                  email,
                  style: style12.copyWith(
                    color: whiteColor.withValues(alpha: 0.85),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      Positioned(
        top: 130,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: blackColor,
                shape: BoxShape.circle,
                border: Border.all(color: golden, width: 2),
              ),
              child: CircleAvatar(
                radius: 46,
                backgroundColor: lightBlack,
                child: Icon(Icons.person, size: 50, color: golden),
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: golden,
                  shape: BoxShape.circle,
                  border: Border.all(color: blackColor, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
