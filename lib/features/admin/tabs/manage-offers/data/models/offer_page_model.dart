import 'package:json_annotation/json_annotation.dart';
import 'offer_model.dart';
import 'sort_model.dart';
import 'pageable_model.dart';

part 'offer_page_model.g.dart';

@JsonSerializable()
class OfferPageModel {
  final int? totalPages;
  final int? totalElements;
  final bool? first;
  final bool? last;
  final int? size;
  final List<OfferModel>? content;
  final int? number;
  final List<SortModel>? sort;
  final int? numberOfElements;
  final PageableModel? pageable;
  final bool? empty;

  OfferPageModel({
    this.totalPages,
    this.totalElements,
    this.first,
    this.last,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.pageable,
    this.empty,
  });

  factory OfferPageModel.fromJson(Map<String, dynamic> json) =>
      _$OfferPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferPageModelToJson(this);
}