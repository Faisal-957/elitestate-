import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String? id;
  final String title;
  final String location;
  final String ownerId;
  final String ownerName;
  final String description;

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
    required this.description,

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
      'title': title,
      'location': location,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'description': description,

      // 'ownerName': ownername,
      "createdAt": FieldValue.serverTimestamp(),
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
      description: map["description"] ?? "",
    );
  }
}
