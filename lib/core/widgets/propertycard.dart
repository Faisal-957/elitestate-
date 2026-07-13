import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyCard({super.key, required this.property, this.onTap});

  static String formatPrice(double price) {
    final value = price.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      final posFromEnd = value.length - i;
      buffer.write(value[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }

  Widget _featureChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: golden.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 15, color: golden),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: whiteColor,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.asset(
                    "assets/images/home.jpg",
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                ///////////////////////////// Favorite icon//////////////////////////////

                /////////////////////////// Price tag/////////////////////////////////////
                Positioned(
                  left: 12,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      gradient: primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "\PKR ${formatPrice(property.price)}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            ///////////////// property title////////////////////
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  ///////////////////////// Location///////////////////////////////////
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: golden),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: greyColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: golden),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          property.ownerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: greyColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //////////// divider/////////////////////////////////
                  const SizedBox(height: 12),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.08),
                    height: 1,
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _featureChip(
                        Icons.bed_outlined,
                        "${property.bedrooms} Beds",
                      ),
                      _featureChip(
                        Icons.bathtub_outlined,
                        "${property.bathrooms} Baths",
                      ),
                      _featureChip(
                        Icons.square_foot_outlined,
                        "${property.area.toStringAsFixed(0)} sqft",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _OwnerName extends StatelessWidget {
//   final PropertyModel property;

//   const _OwnerName({required this.property});

//   static const _textStyle = TextStyle(
//     color: whiteColor,
//     fontSize: 13,
//     fontWeight: FontWeight.w600,
//   );

//   @override
//   Widget build(BuildContext context) {
//     if (property.ownername.isNotEmpty) {
//       return Text(
//         " ${property.ownername}",
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: _textStyle,
//       );
//     }

//     // if (property.ownerId.isEmpty) {
//     //   return const Text("Owner: Unknown", style: _textStyle);
//     // }

//     return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//       future: FirebaseFirestore.instance
//           .collection('users')
//           .doc(property.ownerId)
//           .get(),
//       builder: (context, snapshot) {
//         final name = snapshot.data?.data()?['name'] as String?;
//         return Text(
//           "Owner: ${name?.isNotEmpty == true ? name : 'Unknown'}",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: _textStyle,
//         );
//       },
//     );
//   }
// }
