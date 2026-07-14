import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/lable_text.dart';
import 'package:elitestate/core/widgets/profile_screenwidgets.dart';
import 'package:elitestate/view/profile_screen/aboutus.dart';
import 'package:elitestate/view/profile_screen/logout_screen.dart';
import 'package:elitestate/view/profile_screen/my_properties.dart';
import 'package:elitestate/view/profile_screen/privacy.dart';

import 'package:elitestate/view/profile_screen/terms_condition.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AuthViewModel>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),

            30.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textfoamlabel("Property"),
                  12.verticalSpace,
                  MenuCard(
                    icon: Icons.apartment_rounded,
                    title: "My Properties",
                    subtitle: "View all listed properties",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPropertiesScreen(),
                        ),
                      );
                    },
                  ),
                  10.verticalSpace,

                  24.verticalSpace,
                  textfoamlabel("General"),
                  12.verticalSpace,
                  MenuCard(
                    icon: Icons.info_outline_rounded,
                    title: "About Us",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ),
                      );
                    },
                  ),
                  10.verticalSpace,
                  MenuCard(
                    icon: Icons.description_outlined,
                    title: "Terms and Conditions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Termcondition(),
                        ),
                      );
                    },
                  ),
                  10.verticalSpace,
                  MenuCard(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy and Policy",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolic(),
                        ),
                      );
                    },
                  ),
                  24.verticalSpace,
                  textfoamlabel("Account"),
                  12.verticalSpace,
                  MenuCard(
                    icon: Icons.logout_rounded,
                    title: "Logout",
                    isDanger: true,
                    onTap: () {
                      LogoutBottomSheet.show(context);
                    },
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
