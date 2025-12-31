class AddressModel {
  final String id;
  final String state;
  final String city;
  final String street;
  final String building;
  final String? notes;
  final String userId;
  final String createdAt;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.building,
    this.notes,
    required this.userId,
    required this.createdAt,
    this.latitude,
    this.longitude,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      building: json['building'] ?? '',
      notes: json['notes'],
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isDefault: json['default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'city': city,
      'street': street,
      'building': building,
      'notes': notes,
      'userId': userId,
      'createdAt': createdAt,
      'latitude': latitude,
      'longitude': longitude,
      'default': isDefault,
    };
  }

  String get fullAddress => '$street, $building, $city, $state';
}
