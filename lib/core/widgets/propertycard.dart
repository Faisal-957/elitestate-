import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyCard extends StatefulWidget {
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

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  int activeIndex = 0;

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
      onTap: widget.onTap,
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
            ///////////////////////////////////////// property image //////////////////////////
            Consumer<PropertyViewModel>(
              builder: (context, value, child) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 190,
                        autoPlay: false,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                      items:
                          [
                            "assets/images/home.jpg",
                            "assets/images/home2.jpg",
                            "assets/images/interior.jpg",
                            "assets/images/home2.jpg",
                            "assets/images/interior2.jpg",
                          ].map((image) {
                            return Image.asset(
                              image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: 5,
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
              ),
            ),
            ///////////////// property title  and price title ////////////////////
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.property.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: golden.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "\PKR ${PropertyCard.formatPrice(widget.property.price)}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  6.verticalSpace,

                  ///////////////////////// Location///////////////////////////////////
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: golden),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          widget.property.location,
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
                  8.verticalSpace,
                  //////////////////////// owner//////////////////////////////////////
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: golden),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          widget.property.ownerName,
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

                  ///////////////////////// Description/////////////////////////////
                  8.verticalSpace,
                  Row(
                    children: [
                      Icon(Icons.description, color: golden, size: 16),
                      8.horizontalSpace,
                      Text(
                        widget.property.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: greyColor, fontSize: 13),
                      ),
                    ],
                  ),

                  //////////// divider/////////////////////////////////
                  12.verticalSpace,
                  Divider(
                    color: Colors.white.withValues(alpha: 0.08),
                    height: 1,
                  ),
                  12.verticalSpace,
                  ///////////////////////// bed baht area icons////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _featureChip(
                        Icons.bed_outlined,
                        "${widget.property.bedrooms} Beds",
                      ),
                      _featureChip(
                        Icons.bathtub_outlined,
                        "${widget.property.bathrooms} Baths",
                      ),
                      _featureChip(
                        Icons.square_foot_outlined,
                        "${widget.property.area.toStringAsFixed(0)} sqft",
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
