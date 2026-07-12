import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: golden),
        title: Text("About Us", style: style16.copyWith(color: golden)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "EliteState is a modern real estate platform built to make buying, selling, and renting property effortless. We connect buyers, tenants, and property owners directly, cutting through the clutter of traditional real estate listings with verified properties, transparent pricing, and a seamless browsing experience.",
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Our Mission",
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Our mission is to simplify the property journey for everyone. Whether you're searching for your first home, listing a property for sale, or looking for a rental, EliteState brings verified listings, honest information, and powerful search tools together in one place so you can make confident decisions.",
              style: style16.copyWith(
                fontWeight: FontWeight.w300,
                color: whiteColor.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Why Choose Us',
              style: style18.copyWith(
                color: golden,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Verified property listings with accurate details and images\n"
              "Advanced search and filters to find the right property faster\n"
              "Direct communication between buyers, sellers, and agents\n"
              "Save and manage your favorite properties in one place\n"
              "A secure, transparent, and user-friendly experience from search to sale",
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
