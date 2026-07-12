import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class Addproperty extends StatelessWidget {
  final titleController = TextEditingController();
  final locationController = TextEditingController();

  final priceController = TextEditingController();
  final bedroomController = TextEditingController();
  final bathroomController = TextEditingController();
  final areaController = TextEditingController();
  Addproperty({super.key});

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: golden,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Add Property",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/logo3.png", scale: 4)),
                10.verticalSpace,
                Text(
                  "List Your Property",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                6.verticalSpace,
                Text(
                  "Fill in the details below to publish your listing",
                  style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                ),
                20.verticalSpace,

                _sectionLabel("PROPERTY TITLE"),
                CustomTextFormField(
                  controller: titleController,
                  hintText: "e.g. Modern 3 Bed Villa",
                  prefixIcon: Icons.home_work_outlined,
                ),
                16.verticalSpace,

                _sectionLabel("LOCATION"),
                CustomTextFormField(
                  controller: locationController,
                  hintText: "e.g. Karachi, Pakistan",
                  prefixIcon: Icons.location_on_outlined,
                ),
                16.verticalSpace,

                _sectionLabel("PRICE"),
                CustomTextFormField(
                  controller: priceController,
                  hintText: "Enter price",
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                20.verticalSpace,

                _sectionLabel("PROPERTY DETAILS"),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: bedroomController,
                        hintText: "Bedrooms",
                        prefixIcon: Icons.bed_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CustomTextFormField(
                        controller: bathroomController,
                        hintText: "Bathrooms",
                        prefixIcon: Icons.bathtub_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,

                CustomTextFormField(
                  controller: areaController,
                  hintText: "Area (sqft)",
                  prefixIcon: Icons.square_foot_outlined,
                  keyboardType: TextInputType.number,
                ),
                28.verticalSpace,

                CustomButton(
                  text: "Add Property",
                  onPressed: () async {
                    final price = double.tryParse(priceController.text);
                    final bedrooms = int.tryParse(bedroomController.text);
                    final bathrooms = int.tryParse(bathroomController.text);
                    final area = double.tryParse(areaController.text);

                    if (titleController.text.isEmpty ||
                        locationController.text.isEmpty ||
                        price == null ||
                        bedrooms == null ||
                        bathrooms == null ||
                        area == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill all fields with valid values",
                          ),
                        ),
                      );
                      return;
                    }
                    print(FirebaseAuth.instance.currentUser?.uid);
                    final property = PropertyModel(
                      ownerId: FirebaseAuth.instance.currentUser!.uid,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      location: locationController.text,
                      ownername: context.read<AuthViewModel>().userName,
                      price: price,
                      bedrooms: bedrooms,
                      bathrooms: bathrooms,
                      area: area,
                    );

                    try {
                      await context.read<PropertyViewModel>().addProperty(
                        property,
                      );

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Property Added Successfully"),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add property: $e")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
