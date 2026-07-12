class PropertyModel {
  final String id;
  final String title;
  final String location;
  final String ownerId;
  final String ownername;

  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final bool isFavorite;

  PropertyModel({
    required this.id,
    required this.title,
    required this.ownername,
    required this.location,

    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFavorite = false,
    required this.ownerId,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> data, {String? docId}) {
    return PropertyModel(
      id: (data['id'] as String?) ?? docId ?? '',
      title: (data['title'] as String?) ?? '',
      ownername: (data['ownerName'] as String?) ?? '', // 👈 Add t
      location: (data['location'] as String?) ?? '',
      price: ((data['price'] as num?) ?? 0).toDouble(),
      bedrooms: (data['bedrooms'] as num?)?.toInt() ?? 0,
      bathrooms: (data['bathrooms'] as num?)?.toInt() ?? 0,
      area: ((data['area'] as num?) ?? 0).toDouble(),
      isFavorite: (data['isFavorite'] as bool?) ?? false,
      ownerId: (data['ownerId'] as String?) ?? '',
    );
  }
}
