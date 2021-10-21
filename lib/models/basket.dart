class Basket {
  int id = 0;
  String id1c = '';
  int article = 0;
  int brandId = 0;
  int categoryId = 0;
  int measureId = 0;
  String name1c = '';
  String name = '';
  String image = '';
  int price = 0;
  String remainder = '';
  String createdAt = '';
  String updatedAt = '';
  bool enabled = false;
  int rating = 0;
  String imageOptimized = '';
  String imageResized = '';
  int offPrice = 0;
  int priceA = 0;
  int productId = 0;
  int type = 0;
  double allPrice = 0;
  double count = 0;

  Basket({
    required this.id,
    required this.id1c,
    required this.article,
    required this.brandId,
    required this.categoryId,
    required this.measureId,
    required this.name1c,
    required this.name,
    required this.image,
    required this.price,
    required this.remainder,
    required this.createdAt,
    required this.updatedAt,
    required this.enabled,
    required this.rating,
    required this.imageOptimized,
    required this.imageResized,
    required this.offPrice,
    required this.productId,
    required this.priceA,
    required this.type,
    required this.allPrice,
    required this.count
  });

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id1c = json['id_1c'];
    article = json['article'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    measureId = json['measure_id'];
    name1c = json['name_1c'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    remainder = json['remainder'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enabled = json['enabled'];
    rating = json['rating'];
    imageOptimized = json['image_optimized'];
    imageResized = json['image_resized'];
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
    data['image'] = image;
    data['price'] = price;
    data['remainder'] = remainder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['enabled'] = enabled;
    data['rating'] = rating;
    data['image_optimized'] = imageOptimized;
    data['image_resized'] = imageResized;
    data['off_price'] = offPrice;
    data['price_a'] = priceA;
    data['product_id'] = productId;
    data['type'] = type;
    data['all_price'] = allPrice;
    data['count'] = count;
    return data;
  }

}
