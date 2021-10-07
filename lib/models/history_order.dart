import 'history_address.dart';
import 'history_basket.dart';

class HistoryOrder {
  String name = '';
  int id = 0;
  int userId = 0;
  String deliveryTime = '';
  List<HistoryBasket> basket = [];
  Address address = Address(latitude: '', longitude: '', deliveryTime: '');
  String createdAt = '';
  String updatedAt = '';
  int storeId = 0;
  String mobileId = '';
  var deliveredAt;
  var deletedAt;
  int status = 0;
  String paymentAt = '';
  bool dogovor = false;
  String bin = '';
  int priceCategory = 0;
  int laravelThroughKey = 0;

  HistoryOrder({
    required this.name,
    required this.id,
    required this.userId,
    required this.deliveryTime,
    required this.basket,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.storeId,
    required this.mobileId,
    this.deliveredAt,
    this.deletedAt,
    required this.status,
    required this.paymentAt,
    required this.dogovor,
    required this.bin,
    required this.priceCategory,
    required this.laravelThroughKey
  });

  HistoryOrder.fromJson(Map<String, dynamic> json) {
    name = json['store_name'];
    id = json['id'];
    userId = json['user_id'];
    deliveryTime = json['delivery_time'];
    if (json['basket'] != null) {
      basket = <HistoryBasket>[];
      json['basket'].forEach((v) {
        basket.add(HistoryBasket.fromJson(v));
      });
    }
    address =
    (json['address'] != null ? Address.fromJson(json['address']) : null)!;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    mobileId = json['mobile_id'];
    deliveredAt = json['delivered_at'];
    deletedAt = json['deleted_at'];
    status = json['status'];
    paymentAt = json['payment_at'];
    dogovor = json['dogovor'];
    bin = json['bin'];
    priceCategory = json['priceCategory'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_name'] = name;
    data['id'] = id;
    data['user_id'] = userId;
    data['delivery_time'] = deliveryTime;
    data['basket'] = basket.map((v) => v.toJson()).toList();
    data['address'] = address.toJson();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['store_id'] = storeId;
    data['mobile_id'] = mobileId;
    data['delivered_at'] = deliveredAt;
    data['deleted_at'] = deletedAt;
    data['status'] = status;
    data['payment_at'] = paymentAt;
    data['dogovor'] = dogovor;
    data['bin'] = bin;
    data['priceCategory'] = priceCategory;
    data['laravel_through_key'] = laravelThroughKey;
    return data;
  }
}