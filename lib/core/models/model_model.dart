
import 'dart:convert';

class ModelModel {
  ModelModel({
    required this.id,
    required this.value,
    required this.name,
    required this.popular,
    required this.parent,
  });

  String id;
  String value;
  String name;
  int popular;
  int parent;

  factory ModelModel.fromRawJson(String str) => ModelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory ModelModel.empty() => ModelModel.fromJson({});
  factory ModelModel.fromJson(Map<String, dynamic> json) => ModelModel(
    id: json["id"]??"",
    value: json["value"]??"",
    name: json["name"]??"",
    popular: json["popular"]??0,
    parent: json["parent"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "name": name,
    "popular": popular,
    "parent": parent,
  };
}
