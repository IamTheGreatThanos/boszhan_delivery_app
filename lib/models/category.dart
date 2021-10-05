import 'dart:convert';

Category brandFromJson(String str) {
  final jsonData = json.decode(str);
  return Category.fromMap(jsonData);
}

class Category {
  int id;
  String name;
  String name_1c;
  // ignore: non_constant_identifier_names
  int brand_id;
  bool enabled;

  Category({
    required this.id,
    required this.name,
    required this.name_1c,
    // ignore: non_constant_identifier_names
    required this.brand_id,
    required this.enabled,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      name_1c: json["name_1c"],
      brand_id: json["brand_id"],
      enabled: json["enabled"] > 0 ? true : false);

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "name_1c": name_1c,
    "brand_id": brand_id,
    "enabled": enabled,
  };
}

String brandToJson(Category data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
