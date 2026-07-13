import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatefulWidget {
  PropertyModel dataproperty;

  PropertyDetailsScreen({super.key, required this.dataproperty});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
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
              _buildImageHeader(context),
              const SizedBox(height: 16),
              _buildTitleAndPrice(),
              const SizedBox(height: 16),
              _buildStatsRow(),
              const SizedBox(height: 8),
              _buildOwnerRow(),
              const SizedBox(height: 8),
              _buildDescription(),
              const SizedBox(height: 16),
              _buildContactButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Top image with back / favorite buttons and dot indicators
  Widget _buildImageHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
        height: 230,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
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

  // Title, location and price badge
  Widget _buildTitleAndPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.dataproperty.title,
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
                  widget.dataproperty.location,
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
                  text:
                      ("PKR ${PropertyCard.formatPrice(widget.dataproperty.price)}"),
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

  // Beds / baths / sqft stat cards
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.bed_outlined,
            label: widget.dataproperty.bathrooms.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.bathtub_outlined,
            label: widget.dataproperty.bathrooms.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.straighten,
            label: widget.dataproperty.area.toString(),
          ),
        ),
      ],
    );
  }

  Widget _statCard({required IconData icon, required String label}) {
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

  // Owner avatar, name, and call / message actions
  Widget _buildOwnerRow() {
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
                  widget.dataproperty.ownerName,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Owner',
                  style: TextStyle(color: textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          _ownerActionButton(icon: Icons.call, onTap: () {}),
          const SizedBox(width: 8),
          _ownerActionButton(icon: Icons.chat_bubble_outline, onTap: () {}),
        ],
      ),
    );
  }

  Widget _ownerActionButton({
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

  // Description section
  Widget _buildDescription() {
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
          const Text(
            'Spacious two-storey house with a private pool and covered '
            'porch, close to the city center.',
            style: TextStyle(color: textSecondary, fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }

  // Bottom "Contact owner" call-to-action
  Widget _buildContactButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: open contact / booking flow
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: const Color(0xFF3A2E0A),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Contact owner',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
