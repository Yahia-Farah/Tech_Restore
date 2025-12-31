class AddAddressRequestModel {
  final String state;
  final String city;
  final String street;
  final String building;
  final String? notes;
  final bool isDefault;
  final double latitude;
  final double longitude;

  AddAddressRequestModel({
    required this.state,
    required this.city,
    required this.street,
    required this.building,
    this.notes,
    required this.isDefault,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'city': city,
      'street': street,
      'building': building,
      'notes': notes,
      'isDefault': isDefault,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
