class Basket {
  int id = 0;
  String id1c = '';
  int article = 0;
  int brandId = 0;
  int categoryId = 0;
  int measureId = 0;
  String name1c = '';
  String name = '';
  int price = 0;
  String createdAt = '';
  String updatedAt = '';
  int rating = 0;
  int offPrice = 0;
  int priceA = 0;
  int productId = 0;
  int type = 0;
  double allPrice = 0;
  double count = 0;
  bool isChecked = false;

  Basket(
      {required this.id,
      required this.id1c,
      required this.article,
      required this.brandId,
      required this.categoryId,
      required this.measureId,
      required this.name1c,
      required this.name,
      required this.price,
      required this.createdAt,
      required this.updatedAt,
      required this.rating,
      required this.offPrice,
      required this.productId,
      required this.priceA,
      required this.type,
      required this.allPrice,
      required this.count});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id1c = json['id_1c'];
    article = json['article'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    measureId = json['measure_id'];
    name1c = json['name_1c'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['rating'];
    offPrice = json['off_price'];
    priceA = json['price_a'];
    productId = json['product_id'];
    type = json['type'];
    allPrice = double.parse(json['all_price'].toString());
    count = double.parse(json['count'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_1c'] = id1c;
    data['article'] = article;
    data['brand_id'] = brandId;
    data['category_id'] = categoryId;
    data['measure_id'] = measureId;
    data['name_1c'] = name1c;
    data['name'] = name;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['rating'] = rating;
    data['off_price'] = offPrice;
    data['price_a'] = priceA;
    data['product_id'] = productId;
    data['type'] = type;
    data['all_price'] = allPrice;
    data['count'] = count;
    return data;
  }
}
