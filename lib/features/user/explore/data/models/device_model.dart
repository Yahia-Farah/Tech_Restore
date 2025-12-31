import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable()
class DeviceModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String imageUrl;
  final String condition;
  final DateTime createdAt;
  final String categoryId;
  final String categoryName;
  final bool deleted;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.condition,
    required this.createdAt,
    required this.categoryId,
    required this.categoryName,
    required this.deleted,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    stock,
    imageUrl,
    condition,
    createdAt,
    categoryId,
    categoryName,
    deleted,
  ];
}
