class PropertyModel {
  final String id;
  final String title;
  final String location;

  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final bool isFavorite;

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,

    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFavorite = false,
  });
}
