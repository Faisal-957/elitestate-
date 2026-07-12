import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/custom_button.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                Center(child: Image.asset("assets/images/logo3.png", scale: 3)),

                CustomTextFormField(
                  controller: titleController,
                  hintText: "Title",
                ),
                10.verticalSpace,
                CustomTextFormField(
                  controller: locationController,
                  hintText: "location",
                ),
                10.verticalSpace,

                CustomTextFormField(
                  controller: priceController,
                  hintText: "price",
                ),
                10.verticalSpace,

                CustomTextFormField(
                  controller: bedroomController,
                  hintText: "bedroom",
                ),
                10.verticalSpace,

                CustomTextFormField(
                  controller: bathroomController,
                  hintText: "bathroom",
                ),
                10.verticalSpace,

                CustomTextFormField(
                  controller: areaController,
                  hintText: "area",
                ),
                10.verticalSpace,
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

                    final property = PropertyModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      location: locationController.text,

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
