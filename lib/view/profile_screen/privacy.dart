import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:flutter/material.dart';

class PrivacyPolic extends StatelessWidget {
  const PrivacyPolic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: golden),
        title: Text("Privacy Policy", style: style16.copyWith(color: golden)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Information Collection & Use",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "When you use EliteState, we collect information such as your name, email address, phone number, and the property preferences and listings you interact with. This helps us provide accurate search results, connect you with relevant listings, and improve your overall experience on the app.",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "The information we collect is used to:\n"
              "Show you relevant property listings based on your search and location\n"
              "Allow property owners and agents to respond to your inquiries\n"
              "Save your favorite and recently viewed properties\n"
              "Send important updates about your account and listings",
              textAlign: TextAlign.justify,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Data Sharing & Security",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "We do not sell your personal information to third parties. Your contact details are shared only with the property owner or agent when you make an inquiry about a listing. We use industry-standard security measures to protect your data, and you can request the update or deletion of your account information at any time.",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
