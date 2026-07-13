import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
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
            _buildHeader(context),
            20.verticalSpace,
            _buildStatsRow(),
            24.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Property"),
                  12.verticalSpace,
                  _MenuCard(
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
                  _sectionTitle("General"),
                  12.verticalSpace,
                  _MenuCard(
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
                  _MenuCard(
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
                  _MenuCard(
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
                  _sectionTitle("Account"),
                  12.verticalSpace,
                  _MenuCard(
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

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            color: golden,
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
                    style: style24.copyWith(color: whiteColor, fontSize: 40),
                  ),

                  Text(
                    email,
                    style: style12.copyWith(
                      fontSize: 20,
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

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('properties').snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data?.docs ?? [];
          final totalProperties = docs.length;
          final savedCount = docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['isFavorite'] == true;
          }).length;

          return Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.apartment_rounded,
                  value: "$totalProperties",
                  label: "Listings",
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _StatCard(
                  icon: Icons.favorite_rounded,
                  value: "$savedCount",
                  label: "Saved",
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: style16.copyWith(color: golden, fontWeight: FontWeight.w600),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: lightBlack,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: golden.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: golden, size: 22),
          8.verticalSpace,
          Text(value, style: style24.copyWith(color: whiteColor, fontSize: 20)),
          4.verticalSpace,
          Text(
            label,
            style: style12.copyWith(color: whiteColor.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isDanger;
  final VoidCallback onTap;

  const _MenuCard({
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
