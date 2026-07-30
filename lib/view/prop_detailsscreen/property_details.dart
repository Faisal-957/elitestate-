import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/core/widgets/details_property.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view/addproprety_screen/addprop2.dart';
import 'package:elitestate/view/addproprety_screen/addproperty.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final PropertyModel dataproperty;

  const PropertyDetailsScreen({super.key, required this.dataproperty});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  late PropertyModel property = widget.dataproperty;

  bool get isOwner =>
      context.watch<AuthViewModel>().currentUserId == property.ownerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///// image/////////
              buildImageHeader(context, images: property.images),
              const SizedBox(height: 16),
              //// title and price //////////
              buildTitleAndPrice(property),
              ////// row bath,bed,area,/////////
              const SizedBox(height: 16),

              buildStatsRow(property),
              ////////// icon phone chat name //////////
              const SizedBox(height: 8),

              buildOwnerRow(
                ownerName: property.ownerName,
                onCall: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: golden,
                    title: const Text("Contact Number"),
                    content: Text(
                      property.ownerPhone.isNotEmpty
                          ? property.ownerPhone
                          : "No contact number available",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ////////////// description///////////
              buildDescription(property),
              const SizedBox(height: 16),
              isOwner
                  ? Column(
                      children: [
                        CustomButton(
                          text: "Delete Ad",
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: golden,
                                title: const Text("Delete Property"),
                                content: const Text("Are you sure?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: blackColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: blackColor),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await context
                                  .read<PropertyViewModel>()
                                  .deleteProperty(property.id!);

                              Navigator.pop(context);
                            }
                          },
                        ),
                        10.verticalSpace,
                        CustomButton(
                          text: "Edit Property",
                          onPressed: () async {
                            final updated = await Get.to<PropertyModel>(
                              () => Addproperty(existingProperty: property),
                            );
                            if (updated != null) {
                              setState(() => property = updated);
                            }
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
