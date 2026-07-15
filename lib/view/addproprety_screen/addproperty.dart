// import 'package:elitestate/core/constant/colors.dart';
// import 'package:elitestate/core/widgets/custom_auth.dart';
// import 'package:elitestate/core/widgets/custom_button.dart';
// import 'package:elitestate/core/widgets/lable_text.dart';
// import 'package:elitestate/view/Bottom_navigation/Bottombar.dart';
// import 'package:elitestate/view_model/add_propertyviewmodel.dart';
// import 'package:elitestate/view_model/auth_viewmodel.dart';
// import 'package:elitestate/view_model/bottombar_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:provider/provider.dart';

// class Addproperty extends StatelessWidget {
//   final titleController = TextEditingController();
//   final locationController = TextEditingController();

//   final priceController = TextEditingController();
//   final bedroomController = TextEditingController();
//   final bathroomController = TextEditingController();
//   final areaController = TextEditingController();
//   final descriptioncontroller = TextEditingController();
//   Addproperty({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: blackColor,
//       appBar: AppBar(
//         backgroundColor: blackColor,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           "Add Property",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       ///body///////////////////////////////////////////
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 10.verticalSpace,
//                 Text(
//                   "List Your Property",
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 6.verticalSpace,
//                 Text(
//                   "Fill in the details below to publish your listing",
//                   style: TextStyle(fontSize: 13.sp, color: Colors.white70),
//                 ),
//                 20.verticalSpace,

//                 textfoamlabel("PROPERTY TITLE"),
//                 CustomTextFormField(
//                   controller: titleController,
//                   hintText: "e.g. Modern 3 Bed Villa",
//                   prefixIcon: Icons.home_work_outlined,
//                 ),
//                 16.verticalSpace,

//                 textfoamlabel("LOCATION"),
//                 CustomTextFormField(
//                   controller: locationController,
//                   hintText: "e.g. Karachi, Pakistan",
//                   prefixIcon: Icons.location_on_outlined,
//                 ),
//                 16.verticalSpace,

//                 textfoamlabel("PRICE"),
//                 CustomTextFormField(
//                   controller: priceController,
//                   hintText: "Enter price",
//                   prefixIcon: Icons.attach_money,
//                   keyboardType: TextInputType.number,
//                 ),
//                 20.verticalSpace,

//                 textfoamlabel("PROPERTY DETAILS"),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: bedroomController,
//                         hintText: "Bedrooms",
//                         prefixIcon: Icons.bed_outlined,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     10.horizontalSpace,
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: bathroomController,
//                         hintText: "Bathrooms",
//                         prefixIcon: Icons.bathtub_outlined,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 16.verticalSpace,

//                 CustomTextFormField(
//                   controller: areaController,
//                   hintText: "Area (sqft)",
//                   prefixIcon: Icons.square_foot_outlined,
//                   keyboardType: TextInputType.number,
//                 ),
//                 16.verticalSpace,
//                 textfoamlabel("DESCRIPTION"),

//                 CustomTextFormField(
//                   controller: descriptioncontroller,
//                   hintText: "Description",
//                   prefixIcon: Icons.description,
//                 ),
//                 28.verticalSpace,

//                 /////////////////////////// add property//////////////////////////
//                 CustomButton(
//                   text: "Add Property",
//                   onPressed: () async {
//                     final authVm = context.read<AuthViewModel>();
//                     if (authVm.userName.isEmpty) {
//                       await authVm.getUserData();
//                     }
//                     if (!context.mounted) return;

//                     try {
//                       await context.read<PropertyViewModel>().submitNewProperty(
//                         title: titleController.text,
//                         location: locationController.text,
//                         price: priceController.text,
//                         bedrooms: bedroomController.text,
//                         bathrooms: bathroomController.text,
//                         area: areaController.text,
//                         description: descriptioncontroller.text,
//                         ownerId: authVm.currentUserId ?? '',
//                         ownerName: authVm.userName,
//                       );
//                     } catch (e) {
//                       if (!context.mounted) return;
//                       ScaffoldMessenger.of(
//                         context,
//                       ).showSnackBar(SnackBar(content: Text(e.toString())));
//                       return;
//                     }

//                     if (!context.mounted) return;
//                     context.read<BottomNavViewModel>().changeIndex(0);

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Property Added Successfully"),
//                       ),
//                     );
//                     Get.offAll(BottomNavScreen());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
