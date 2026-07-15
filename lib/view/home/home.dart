import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/view/prop_detailsscreen/property_details.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:elitestate/view_model/homeviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer2<AuthViewModel, Homeviewmodel>(
                builder: (context, authVm, homeVm, child) {
                  return Row(
                    children: [
                      Image.asset("assets/images/logo3.png", scale: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeVm.greeting(),
                            style: style12.copyWith(
                              color: whiteColor.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            authVm.userName.isNotEmpty
                                ? authVm.userName
                                : "Guest",
                            style: style24.copyWith(
                              color: whiteColor,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              Consumer<Homeviewmodel>(
                builder: (context, homeVm, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: homeVm.searchController,
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
                          icon: const Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              20.verticalSpace,

              Expanded(
                child: Consumer<Homeviewmodel>(
                  builder: (context, homeVm, child) {
                    return StreamBuilder(
                      stream: homeVm.propertiesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(child: CircularProgressIndicator()),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No Property ",
                              style: TextStyle(color: whiteColor),
                            ),
                          );
                        }

                        final data = homeVm.filterProperties(snapshot.data!);

                        if (data.isEmpty) {
                          return Center(
                            child: Text(
                              "No results found",
                              style: TextStyle(color: whiteColor),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final property = data[index];

                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => PropertyDetailsScreen(
                                    dataproperty: property,
                                  ),
                                );
                              },

                              child: PropertyCard(property: property),
                            );
                          },
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
