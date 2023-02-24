// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

List<BrandsModel> brandsModelFromJson(String str) => List<BrandsModel>.from(json.decode(str).map((x) => BrandsModel.fromJson(x)));

String brandsModelToJson(List<BrandsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsModel {
  BrandsModel({
    required this.id,
    required this.value,
    required this.name,
    required this.popular,
  });

  String id;
  String value;
  String name;
  int popular;

  factory BrandsModel.empty() => BrandsModel.fromJson({});
  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
    id: json["id"]??"",
    value: json["value"]??"",
    name: json["name"]??"",
    popular: json["popular"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "name": name,
    "popular": popular,
  };
}
