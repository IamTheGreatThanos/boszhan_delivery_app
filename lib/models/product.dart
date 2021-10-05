import 'dart:convert';

class Product {
  int id;
  String id_1c;
  int article;
  // ignore: non_constant_identifier_names
  int brand_id;
  // ignore: non_constant_identifier_names
  int category_id;

  // ignore: non_constant_identifier_names
  int measure_id;
  String name_1c;
  String name;
  String image;
  var price;
  double remainder;
  bool enabled;
  int rating;
  int presale_id;

  Product(
      {required this.id,
        required this.id_1c,
        required this.article,
        required this.brand_id,
        required this.category_id,
        required this.measure_id,
        required this.name_1c,
        required this.name,
        this.price,
        required this.remainder,
        required this.enabled,
        required this.rating,
        required this.presale_id,
        required this.image})
  ;

  factory Product.fromMap(Map<String, dynamic> json) {
    print("123 json 123 1313");
    print(json);
    var remainder = json["remainder"];
    if (remainder.runtimeType == int) {
      remainder = remainder.toDouble();
    }

    return Product(
      id: json["id"],
      id_1c: json["id_1c"],
      article: json["article"],
      brand_id: json["brand_id"],
      category_id: json["category_id"],
      measure_id: json["measure_id"],
      name_1c: json["name_1c"],
      name: json["name"],
      price: json["price"],
      remainder: remainder,
      enabled: json["enabled"] > 0 ? true : false,
      rating: json["rating"],
      presale_id: json["presale_id"],
      image: json["image"],
    );
  }

  Product productFromJson(String str) {
    final jsonData = json.decode(str);
    return Product.fromMap(jsonData);
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "id_1c": id_1c,
    "article": article,
    "brand_id": brand_id,
    "category_id": category_id,
    "measure_id": measure_id,
    "name_1c": name_1c,
    "name": name,
    "price": price,
    "remainder": remainder,
    "enabled": enabled,
    "rating": rating,
    "presale_id": presale_id,
    "image": image,
  };
}

String brandToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
