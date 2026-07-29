import 'dart:io';

import 'package:elitestate/view_model/imagepicker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
////////////////// image card //////////////////////////

class Imagepicker extends StatelessWidget {
  const Imagepicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagepickerViewmodel>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          height: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Add Pictures Button
              ElevatedButton.icon(
                onPressed: () {
                  vm.pickMultipleImages();
                },
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Add Pictures"),
              ),

              const SizedBox(height: 10),

              // Images - Horizontal Scroll + Maximum 2 Rows
              if (vm.existingImageUrls.isNotEmpty ||
                  vm.selectedImages.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        vm.existingImageUrls.length + vm.selectedImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final bool isExisting =
                          index < vm.existingImageUrls.length;
                      final Widget image = isExisting
                          ? Image.network(
                              vm.existingImageUrls[index],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(
                                vm
                                    .selectedImages[index -
                                        vm.existingImageUrls.length]
                                    .path,
                              ),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            );

                      return Stack(
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: image,
                          ),

                          // Remove Button
                          Positioned(
                            right: 2,
                            top: 2,
                            child: GestureDetector(
                              onTap: () {
                                if (isExisting) {
                                  vm.removeExistingImage(index);
                                } else {
                                  vm.removeImage(
                                    index - vm.existingImageUrls.length,
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
