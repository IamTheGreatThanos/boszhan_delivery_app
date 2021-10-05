import 'dart:convert';

Brand brandFromJson(String str) {
  final jsonData = json.decode(str);
  return Brand.fromMap(jsonData);
}

class Brand {
  int id;
  int backend_id;
  String name;
  bool enabled;

  Brand({
    required this.id,
    required this.backend_id,
    required this.name,
    required this.enabled,
  });

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
      id: json["id"],
      backend_id: json["id"],
      name: json["name"],
      enabled: json["enabled"] > 0 ? true : false);

  Map<String, dynamic> toMap() => {
    "id": id,
    "backend_id": backend_id,
    "name": name,
    "enabled": enabled,
  };
}

String brandToJson(Brand data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
