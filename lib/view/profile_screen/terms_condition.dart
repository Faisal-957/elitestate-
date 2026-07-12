import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:flutter/material.dart';

class Termcondition extends StatelessWidget {
  const Termcondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: golden),
        title: Text(
          "Terms & Conditions",
          style: style16.copyWith(color: golden),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By creating an account or using the EliteState app, you agree to these Terms & Conditions. EliteState is a platform that lists properties for sale and rent submitted by property owners and agents. We do not own, manage, or guarantee any property listed on the platform, and all transactions between buyers and sellers are the responsibility of the parties involved.",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Property Listings",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Users who list properties are responsible for ensuring that the information, pricing, images, and ownership details provided are accurate and up to date. EliteState reserves the right to remove any listing that is found to be misleading, fraudulent, or in violation of these terms.",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "User Conduct",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "You agree not to misuse the app, post false property information, or contact other users for purposes unrelated to genuine property inquiries. Violation of these terms may result in suspension or termination of your account.",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Changes to these Terms & Conditions",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "We may update these Terms & Conditions from time to time to reflect changes in our services or legal requirements. Continued use of the app after any changes constitutes your acceptance of the updated terms.",
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
