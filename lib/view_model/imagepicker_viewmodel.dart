import 'dart:io';

import 'package:elitestate/core/services/claoudnary_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagepickerViewmodel extends ChangeNotifier {
  final CloudinaryService _cloudinaryService = CloudinaryService();

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];

  // Existing images (already uploaded URLs) shown when editing a property
  List<String> existingImageUrls = [];

  void setExistingImages(List<String> urls) {
    existingImageUrls = List<String>.from(urls);
    notifyListeners();
  }

  void removeExistingImage(int index) {
    existingImageUrls.removeAt(index);
    notifyListeners();
  }

  void resetAll() {
    selectedImages.clear();
    existingImageUrls.clear();
    notifyListeners();
  }

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages = images;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  } // Remove single image

  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  //Clear all images
  void clearImages() {
    selectedImages.clear();
    notifyListeners();
  }

  // Upload all selected images to Cloudinary and return their URLs
  Future<List<String>> uploadSelectedImages() async {
    final List<String> imageUrls = [];

    for (final image in selectedImages) {
      final url = await _cloudinaryService.uploadImage(File(image.path));
      if (url != null) {
        imageUrls.add(url);
      }
    }

    return imageUrls;
  }
  /////////////// profile image picker//////////

  XFile? profileImage;

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        profileImage = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Profile image error: $e");
    }
  }

  Future<String?> uploadProfileImage() async {
    if (profileImage == null) {
      debugPrint("❌ Profile image is null");
      return null;
    }

    try {
      final url = await _cloudinaryService.uploadImage(
        File(profileImage!.path),
      );
      debugPrint("✅ Cloudinary URL: $url");
      return url;
    } catch (e) {
      debugPrint("Profile image upload error: $e");
      debugPrint("❌ Profile upload error: $e");
      return null;
    }
  }
}
