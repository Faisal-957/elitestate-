import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String? id;
  final String title;
  final String location;
  final String ownerId;
  final String ownerName;
  final String ownerPhone;
  final String description;
  final List<String> images;

  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final Timestamp? createdAt;

  PropertyModel({
    this.id,
    required this.title,

    required this.location,
    required this.ownerId,
    required this.ownerName,
    this.ownerPhone = '',
    required this.description,

    this.images = const [],
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,

    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "ownerId": ownerId,
      "ownerName": ownerName,
      "ownerPhone": ownerPhone,
      'title': title,
      'location': location,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'description': description,
      "images": images,

      // 'ownerName': ownername,
      "createdAt": Timestamp.now(),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map, String? id) {
    return PropertyModel(
      title: map["title"] ?? "",

      location: map["location"] ?? "",
      price: (map["price"] as num?)?.toDouble() ?? 0,
      bedrooms: map["bedrooms"] ?? 0,
      bathrooms: map["bathrooms"] ?? 0,
      area: (map["area"] as num?)?.toDouble() ?? 0,
      id: id,
      ownerId: map["ownerId"] ?? "",
      ownerName: map["ownerName"] ?? "",
      ownerPhone: map["ownerPhone"] ?? "",
      description: map["description"] ?? "",
      images: List<String>.from(map["images"] ?? []),
    );
  }
}
