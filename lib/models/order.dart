import 'dart:convert';

Order brandFromJson(String str) {
  final jsonData = json.decode(str);
  return Order.fromMap(jsonData);
}

class Order {
  String mobile_id;
  String basket;
  String shop_addr;
  String shop_name;
  String shop_phone;
  String shop_bin;
  String latitude;
  String longitude;
  int price;
  int status = 0;
  String time = '';
  int return_price;

  Order({
    required this.mobile_id,
    required this.basket,
    required this.shop_addr,
    required this.shop_name,
    required this.shop_phone,
    required this.shop_bin,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.status,
    required this.time,
    required this.return_price,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    mobile_id: json["mobile_id"],
    basket: json["basket"],
    shop_addr: json["shop_addr"],
    shop_name: json["shop_name"],
    shop_phone: json["shop_phone"],
    shop_bin: json["shop_name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    price: json["price"],
    status: json["status"] ?? 0,
    time: json["time"],
    return_price: json["return_price"],
  );

  Map<String, dynamic> toMap() => {
    "mobile_id": mobile_id,
    "basket": basket,
    "shop_addr": shop_addr,
    "shop_name": shop_name,
    "shop_phone": shop_phone,
    "shop_bin": shop_bin,
    "latitude": latitude,
    "longitude": longitude,
    "price": price,
    "status": status,
    "time": time,
    "return_price": return_price,
  };
}

String brandToJson(Order data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
