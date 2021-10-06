// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:boszhan_delivery_app/models/brand.dart';
// import 'package:boszhan_delivery_app/models/category.dart';
// import 'package:boszhan_delivery_app/models/order.dart';
// import 'package:boszhan_delivery_app/models/basket.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBProvider {
//   DBProvider._();
//
//   static final DBProvider db = DBProvider._();
//
//   Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }
//
//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "TestDB.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Brands ("
//           "id INTEGER PRIMARY KEY,"
//           "backend_id INTEGER,"
//           "name TEXT,"
//           "enabled BOOLEAN"
//           ")");
//       await db.execute("CREATE TABLE Categories ("
//           "id INTEGER PRIMARY KEY,"
//           "name TEXT,"
//           "name_1c TEXT,"
//           "brand_id INTEGER,"
//           "enabled BOOLEAN"
//           ")");
//       await db.execute("CREATE TABLE Products ("
//           "id INTEGER PRIMARY KEY,"
//           "id_1c TEXT,"
//           "article INTEGER,"
//           "brand_id INTEGER,"
//           "category_id INTEGER,"
//           "measure_id INTEGER,"
//           "name_1c TEXT,"
//           "name TEXT,"
//           "price INTEGER,"
//           "remainder INTEGER,"
//           "enabled BOOLEAN,"
//           "rating INTEGER,"
//           "presale_id INTEGER,"
//           "image_big TEXT,"
//           "image TEXT"
//           ")");
//       await db.execute("CREATE TABLE Orders ("
//           "mobile_id TEXT,"
//           "basket TEXT,"
//           "shop_addr TEXT,"
//           "shop_name TEXT,"
//           "shop_phone TEXT,"
//           "shop_bin TEXT,"
//           "latitude TEXT,"
//           "longitude TEXT,"
//           "price INTEGER,"
//           "status INTEGER DEFAULT 0,"
//           "time String,"
//           "return_price INTEGER"
//           ")");
//       await db.execute("CREATE TABLE Games ("
//           "id INTEGER PRIMARY KEY,"
//           "game_id TEXT,"
//           "mobile_id TEXT,"
//           "sum_win INTEGER"
//           ")");
//       await db.execute("CREATE TABLE Stores ("
//           "backend_id INTEGER PRIMARY KEY,"
//           "address TEXT,"
//           "bin TEXT,"
//           "name TEXT,"
//           "phone TEXT"
//           ")");
//
//     });
//   }
//
//   Future<List<Brand>> getBrands() async {
//     final db = await database;
//     var res = await db.query("Brands");
//     List<Brand> brands = [];
//     brands = res.isNotEmpty ? res.map((c) => Brand.fromMap(c)).toList() : [];
//     return brands;
//   }
//
//   //@TODO вынести этот простой запрос в 1 метод в 5 утра мне лень это делать CTRL + C  + CTRL + V
//   Future<List<Category>> getCategories() async {
//     final db = await database;
//     var res = await db.query("Categories");
//     List<Category> categories = [];
//     categories = res.isNotEmpty ? res.map((c) => Category.fromMap(c)).toList() : [];
//     return categories;
//   }
//
//   Future<List<Product>> getAllProducts() async {
//     final db = await database;
//     var res = await db.query("Products");
//     List<Product> products = [];
//     products = res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
//     return products;
//   }
//
//
//   Future getAllOrders() async {
//     final db = await database;
//     var res = await db.query(
//       "Orders",
//       orderBy: "time DESC",
//     );
//     List<Order> orders = [];
//     orders = res.isNotEmpty ? res.map((c) => Order.fromMap(c)).toList() : [];
//     List<dynamic> allDates = [];
//
//     orders.forEach((order) {
//       allDates.add(order.time);
//     });
//     // allDates = allDates.toSet().toList();
//     allDates = allDates.toSet().toList();
//     List<dynamic> finalList = [];
//     allDates.forEach((date) {
//       List<dynamic> dateOrders = [];
//       dateOrders = orders.where((order) => order.time == date).toList();
//       int sumOrders = 0;
//       int sumReturnOrders = 0;
//       dateOrders.forEach((order) {
//         sumOrders += order.price;
//         sumReturnOrders += order.return_price;
//       });
//       finalList.add({"date": date, "sum": sumOrders, "return_sum": sumReturnOrders, "orders": dateOrders});
//
//       // dateOrders.add([sumOrders]);
//       print("1241dateOrders");
//       print(dateOrders);
//       // finalList[];
//     });
//     print("finalList");
//     print(finalList);
//     print("finalList");
//
//     return finalList;
//   }
//
//   Future<List<Order>> getAllOrderNotSendToServer() async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Orders where status=?", [0]);
//     List<Order> orders = [];
//     orders = res.isNotEmpty ? res.map((c) => Order.fromMap(c)).toList() : [];
//     return orders;
//   }
//
//   Future getOrderById(String orderId) async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Orders where mobile_id=?", [orderId]);
//     List<Order> orders = [];
//     orders = res.isNotEmpty ? res.map((c) => Order.fromMap(c)).toList() : [];
//     return orders;
//   }
//
//   newBrand(Brand brand) async {
//     final db = await database;
//     var raw = await db.rawInsert(
//         "INSERT OR REPLACE INTO Brands (id,backend_id,name,enabled)"
//             " VALUES (?,?,?,?)",
//         [
//           brand.id,
//           brand.backend_id,
//           brand.name,
//           brand.enabled,
//         ]);
//     return raw;
//   }
//
//   newCategory(Category category) async {
//     final db = await database;
//     var raw = await db.rawInsert(
//         "INSERT OR REPLACE INTO Categories (id,name,name_1c,brand_id,enabled)"
//             " VALUES (?,?,?,?,?)",
//         [
//           category.id,
//           category.name,
//           category.name_1c,
//           category.brand_id,
//           category.enabled,
//         ]);
//     return raw;
//   }
//
//   newOrder(Order order) async {
//     final db = await database;
//     var raw = await db.rawInsert(
//         "INSERT OR REPLACE INTO Orders (mobile_id,basket,shop_addr,shop_name,shop_phone,shop_bin,latitude,longitude,price,status,time,return_price)"
//             " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
//         [
//           order.mobile_id,
//           jsonEncode(order.basket),
//           order.shop_addr,
//           order.shop_name,
//           order.shop_phone,
//           order.shop_bin,
//           order.latitude,
//           order.longitude,
//           order.price,
//           0,
//           DateFormat('MM-dd-yy').format(DateTime.now()),
//           order.return_price
//         ]);
//     return raw;
//   }
//
//   updateOrder(Order order) async {
//     final db = await database;
//     var res = await db.update("Orders", order.toMap(), where: "mobile_id = ?", whereArgs: [order.mobile_id]);
//     return res;
//   }
//
//   removeOrderByPhone(String shop_phone) async {
//     final db = await database;
//     await db.rawDelete("DELETE FROM Orders WHERE shop_phone = $shop_phone");
//   }
//
//   removeOrderByMobileId(String mobileId) async {
//     final db = await database;
//     await db.rawQuery("DELETE FROM Orders WHERE mobile_id=?", [mobileId]);
//   }
//
//   removeGamesByMobileId(String mobileId) async {
//     final db = await database;
//     await db.rawQuery("DELETE FROM Games WHERE mobile_id=?", [mobileId]);
//   }
//
//   newProduct(Product product) async {
//     final db = await database;
//     var raw = await db.rawInsert(
//         "INSERT OR REPLACE INTO Products (id,id_1c,article,brand_id,category_id,measure_id,name_1c,name,price,remainder,enabled,rating,presale_id)"
//             " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
//         [
//           product.id,
//           product.id_1c,
//           product.article,
//           product.brand_id,
//           product.category_id,
//           product.measure_id,
//           product.name_1c,
//           product.name,
//           product.price,
//           product.remainder,
//           product.enabled,
//           product.rating,
//           product.presale_id,
//           product.image,
//         ]);
//     return raw;
//   }
//
//   getCategoriesByBrandId(int brandId) async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Categories where brand_id=?", [brandId]);
//     List<Category> categories = [];
//     categories = res.isNotEmpty ? res.map((c) => Category.fromMap(c)).toList() : [];
//     return categories;
//   }
//
//   getProductsByFilters(int brandId, int categoryId, int page) async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Products WHERE brand_id=? AND category_id=?", [brandId, categoryId]);
//     List<Product> products = [];
//     products = res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
//     return products;
//   }
//
//   removeBrands() async {
//     final db = await database;
//     await db.rawDelete("DELETE FROM Brands WHERE id != 0");
//   }
//
//   removeGame(int id) async {
//     final db = await database;
//     await db.rawDelete("DELETE FROM Games WHERE id = $id");
//   }
//
//   Future getGameSumByMobileId(String mobileId) async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT SUM(sum_win) FROM Games WHERE mobile_id = ?", [mobileId]);
//     return res[0]['SUM(sum_win)'];
//   }
//
//   Future getGamesCountByMobileId(String mobileId) async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT COUNT(*) FROM Games WHERE mobile_id = ?", [mobileId]);
//     return res[0]['COUNT(*)'];
//   }
// }
