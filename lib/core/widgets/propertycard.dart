import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: golden,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: golden.withValues(alpha: 0.35), // Golden glow
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              "assets/images/home.jpg",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price
                Text(
                  "\$${property.price}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Title
                Text(
                  property.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 5),
                    Expanded(child: Text(property.location)),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed),
                        const SizedBox(width: 5),
                        Text("${property.bedrooms} Beds"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.bathtub),
                        const SizedBox(width: 5),
                        Text("${property.bathrooms} Baths"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.square_foot),
                        const SizedBox(width: 5),
                        Text("${property.area} sqft"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
