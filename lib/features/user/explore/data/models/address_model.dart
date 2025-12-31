import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final String id;
  final String state;
  final String city;
  final String street;
  final String building;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final DateTime createdAt;
  @JsonKey(name: 'default')
  final bool isDefault;
  final String fullAddress;

  const AddressModel({
    required this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.building,
    required this.latitude,
    required this.longitude,
    this.notes,
    required this.createdAt,
    required this.isDefault,
    required this.fullAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    state,
    city,
    street,
    building,
    latitude,
    longitude,
    notes,
    createdAt,
    isDefault,
    fullAddress,
  ];
}
