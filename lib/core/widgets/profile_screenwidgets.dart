import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:elitestate/view_model/imagepicker_viewmodel.dart';
import 'dart:io';

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
  return Column(
    children: [
      50.verticalSpace,
      Consumer2<ImagepickerViewmodel, AuthViewModel>(
        builder: (context, vm, authVm, child) {
          final hasLocalImage = vm.profileImage != null;
          final hasSavedImage =
              authVm.profileImageUrl != null &&
              authVm.profileImageUrl!.isNotEmpty;

          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: blackColor,
              shape: BoxShape.circle,
              border: Border.all(color: golden, width: 2),
            ),
            child: GestureDetector(
              onTap: () async {
                await vm.pickProfileImage();
                if (vm.profileImage == null) return;

                final url = await vm.uploadProfileImage();
                if (url == null) return;

                await authVm.updateProfileImage(url);
              },
              child: CircleAvatar(
                radius: 46,
                backgroundColor: lightBlack,

                backgroundImage: hasLocalImage
                    ? FileImage(File(vm.profileImage!.path))
                    : (hasSavedImage
                              ? NetworkImage(authVm.profileImageUrl!)
                              : null)
                          as ImageProvider?,

                // Image nahi hai to icon show hoga
                child: (!hasLocalImage && !hasSavedImage)
                    ? Icon(Icons.person, size: 50, color: golden)
                    : null,
              ),
            ),
          );
        },
      ),
      Consumer<AuthViewModel>(
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
              6.verticalSpace,
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => EditPhoneBottomSheet.show(context, vm.userPhone),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_outlined, size: 14, color: golden),
                      6.horizontalSpace,
                      Text(
                        vm.userPhone.isNotEmpty
                            ? vm.userPhone
                            : "Add phone number",
                        style: style12.copyWith(
                          color: vm.userPhone.isNotEmpty
                              ? whiteColor.withValues(alpha: 0.85)
                              : golden,
                        ),
                      ),
                      6.horizontalSpace,
                      Icon(
                        Icons.edit_outlined,
                        size: 13,
                        color: whiteColor.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

///// edit phone number bottom sheet //
class EditPhoneBottomSheet {
  static void show(BuildContext context, String currentPhone) {
    final controller = TextEditingController(text: currentPhone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: lightBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: lightBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone Number",
                  style: style24.copyWith(color: whiteColor),
                ),
                16.verticalSpace,
                CustomTextFormField(
                  controller: controller,
                  hintText: "e.g. 03001234567",
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                20.verticalSpace,
                CustomButton(
                  text: "Save",
                  onPressed: () async {
                    final phone = controller.text.trim();
                    if (phone.isEmpty) return;

                    await sheetContext.read<AuthViewModel>().updatePhoneNumber(
                      phone,
                    );

                    if (sheetContext.mounted) Navigator.pop(sheetContext);
                  },
                ),
                12.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
