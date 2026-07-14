import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

Widget statCard({required IconData icon, required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Icon(icon, color: gold, size: 18),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildOwnerRow({
  String ownerName = '',
  VoidCallback? onCall,
  VoidCallback? onChat,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: divider, width: 0.5)),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 19,
          backgroundColor: gold,
          child: Icon(Icons.person),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posted By',
                style: TextStyle(color: textSecondary, fontSize: 12),
              ),
              Text(
                ownerName,
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ownerActionButton(icon: Icons.call, onTap: onCall ?? () {}),
        const SizedBox(width: 8),
        ownerActionButton(
          icon: Icons.chat_bubble_outline,
          onTap: onChat ?? () {},
        ),
      ],
    ),
  );
}

Widget ownerActionButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(17),
    child: Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(color: card, shape: BoxShape.circle),
      child: Icon(icon, color: gold, size: 15),
    ),
  );
}

///////////////////////// Top images
Widget buildImageHeader(
  BuildContext context, {
  String imageUrl =
      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.network(
      imageUrl,
      height: 230,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}

Widget circleIconButton({required IconData icon, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.45),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );
}

////////////////////////////// Title, location and price badge
Widget buildTitleAndPrice(PropertyModel property) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.title,
            style: TextStyle(
              color: textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, color: gold, size: 14),
              SizedBox(width: 4),
              Text(
                property.location,
                style: TextStyle(color: textSecondary, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: ("PKR ${PropertyCard.formatPrice(property.price)}"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

/////////////////////////////// Beds / baths / sqft stat cards
Widget buildStatsRow(PropertyModel property) {
  return Row(
    children: [
      Expanded(
        child: statCard(
          icon: Icons.bed_outlined,
          label: property.bedrooms.toString(),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: statCard(
          icon: Icons.bathtub_outlined,
          label: property.bathrooms.toString(),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: statCard(
          icon: Icons.straighten,
          label: property.area.toString(),
        ),
      ),
    ],
  );
}

/////////////////////////////////// Description section
Widget buildDescription(PropertyModel property) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: divider, width: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            color: textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          property.description,
          style: TextStyle(color: textSecondary, fontSize: 13, height: 1.6),
        ),
      ],
    ),
  );
}
