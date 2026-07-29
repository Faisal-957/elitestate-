import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  List<String> images = const [],
}) {
  return _ImageHeader(images: images);
}

class _ImageHeader extends StatefulWidget {
  final List<String> images;

  const _ImageHeader({required this.images});

  @override
  State<_ImageHeader> createState() => _ImageHeaderState();
}

class _ImageHeaderState extends State<_ImageHeader> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        child: Container(
          height: 190,
          width: double.infinity,
          color: card,
          child: Icon(
            Icons.home_outlined,
            size: 48,
            color: gold.withOpacity(0.5),
          ),
        ),
      );
    }
    ////////////////////image property////////////////////////////
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 190,
              autoPlay: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) =>
                  setState(() => _activeIndex = index),
            ),
            items: images.map((image) {
              return CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) {
                  debugPrint("IMAGE URL: $url");
                  debugPrint("IMAGE ERROR: $error");

                  return Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  );
                },
              );
            }).toList(),
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _activeIndex,
                count: images.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: whiteColor,
                  dotColor: golden,
                  paintStyle: PaintingStyle.stroke,
                ),
              ),
            ),
          ),
      ],
    );
  }
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
