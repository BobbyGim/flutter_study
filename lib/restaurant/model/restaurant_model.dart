import 'package:actual/common/const/api.dart';
import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part "restaurant_model.g.dart";

enum RestaurantPriceRangeEnum {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String thumbUrl;
  List<String> tags;
  final RestaurantPriceRangeEnum priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  static pathToUrl(String value) {
    return baseUrl + value;
  }

  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     id: json["id"],
  //     name: json["name"],
  //     thumbUrl: baseUrl + json["thumbUrl"],
  //     tags: List<String>.from(json["tags"]),
  //     priceRange: RestaurantPriceRangeEnum.values.firstWhere(
  //       (e) => e.name == json["priceRange"],
  //     ),
  //     ratings: json["ratings"],
  //     ratingsCount: json["ratingsCount"],
  //     deliveryTime: json["deliveryTime"],
  //     deliveryFee: json["deliveryFee"],
  //   );
  // }
}
