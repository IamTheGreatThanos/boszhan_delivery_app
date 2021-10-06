import 'basket.dart';

class Order {
  int id = 0;
  int orderId = 0;
  int status = 0;
  List<Basket> basket = [];
  String deliveryAt = '';
  String storeName = '';
  int storeId = 0;
  String storeAddress = '';
  double totalCost = 0;
  double totalReturnsCost = 0;
  String counterpartyName = '';
  int bonusGameSum = 0;

  Order({
    required this.id,
    required this.orderId,
    required this.status,
    required this.basket,
    required this.deliveryAt,
    required this.storeName,
    required this.storeId,
    required this.storeAddress,
    required this.totalCost,
    required this.totalReturnsCost,
    required this.counterpartyName,
    required this.bonusGameSum
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    if (json['basket'] != null) {
      basket = <Basket>[];
      json['basket'].forEach((v) {
        basket.add(Basket.fromJson(v));
      });
    }
    deliveryAt = json['delivery_at'];
    storeName = json['store_name'];
    storeId = json['store_id'];
    storeAddress = json['store_address'];
    totalCost = double.parse(json['total_cost'].toString());
    totalReturnsCost = double.parse(json['total_returns_cost'].toString());
    counterpartyName = json['counterparty_name'];
    bonusGameSum = json['bonus_game_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['status'] = status;
    data['basket'] = basket.map((v) => v.toJson()).toList();
    data['delivery_at'] = deliveryAt;
    data['store_name'] = storeName;
    data['store_id'] = storeId;
    data['store_address'] = storeAddress;
    data['total_cost'] = totalCost;
    data['total_returns_cost'] = totalReturnsCost;
    data['counterparty_name'] = counterpartyName;
    data['bonus_game_sum'] = bonusGameSum;
    return data;
  }
}
