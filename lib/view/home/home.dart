import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/services/property.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view/prop_detailsscreen/property_details.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PropertyService propertyService = PropertyService();
  TextEditingController searchcontrollers = TextEditingController();

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<AuthViewModel>(
                      builder: (context, vm, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greeting(),
                              style: style12.copyWith(
                                color: whiteColor.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              vm.userName.isNotEmpty ? vm.userName : "Guest",
                              style: style24.copyWith(
                                color: whiteColor,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightBlack,
                      shape: BoxShape.circle,
                      border: Border.all(color: golden.withValues(alpha: 0.25)),
                    ),
                    child: Badge(
                      backgroundColor: primaryColor,
                      smallSize: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.notifications_none_rounded,
                          color: golden,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,

              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: searchcontrollers,
                      hintText: "search",
                      prefixIcon: Icons.search,
                    ),
                  ),
                  10.horizontalSpace,
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      gradient: primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.tune_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,

              Expanded(
                child: StreamBuilder(
                  stream: propertyService.fetchingProperties(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData) {
                      return Text("No Property yet");
                    }

                    final data = snapshot.data!;

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final property = data[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () =>
                                  PropertyDetailsScreen(dataproperty: property),
                            );
                          },

                          child: PropertyCard(property: property),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
