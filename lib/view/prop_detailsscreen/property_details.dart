import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/core/widgets/details_property.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final PropertyModel dataproperty;

  const PropertyDetailsScreen({super.key, required this.dataproperty});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool get isOwner =>
      context.watch<AuthViewModel>().currentUserId == widget.dataproperty.ownerId;

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
              buildImageHeader(context),
              const SizedBox(height: 16),
              buildTitleAndPrice(widget.dataproperty),
              const SizedBox(height: 16),
              buildStatsRow(widget.dataproperty),
              const SizedBox(height: 8),
              buildOwnerRow(ownerName: widget.dataproperty.ownerName),
              const SizedBox(height: 8),
              buildDescription(widget.dataproperty),
              const SizedBox(height: 16),
              isOwner
                  ? CustomButton(
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
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: blackColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
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
                              .deleteProperty(widget.dataproperty.id!);

                          Navigator.pop(context);
                        }
                      },
                    )
                  : CustomButton(text: "Contact", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
