import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view/prop_detailsscreen/property_details.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ownerId = context.watch<AuthViewModel>().currentUserId ?? '';

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: golden),
        title: Text("My Properties", style: style16.copyWith(color: golden)),
      ),
      body: StreamBuilder<List<PropertyModel>>(
        stream: context.read<PropertyViewModel>().myPropertiesStream(ownerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: golden),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Properties Found",
                style: style16.copyWith(color: whiteColor),
              ),
            );
          }

          final properties = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(PropertyDetailsScreen(dataproperty: properties[index]));
                },

                child: PropertyCard(property: properties[index]),
              );
            },
          );
        },
      ),
    );
  }
}
