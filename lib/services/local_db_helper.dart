import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';


class DBHelper {
  // creating sales table
  static const String myCartTable =
      "CREATE TABLE IF NOT EXISTS cart(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "product_id	TEXT NOT NULL,variant_id	TEXT NOT NULL,name TEXT NOT NULL,product_type TEXT NOT NULL,"
      "variant_name TEXT NOT NULL,unit_price REAL NOT NULL,quantity INTEGER NOT NULL,total REAL NOT NULL,"
      "is_sync INTEGER NOT NULL DEFAULT 0,image_url TEXT NOT NULL,inventory_quantity INTEGER NOT NULL, pr_type TEXT NOT NULL, created_at TEXT NOT NULL,"
      "updated_at TEXT NOT NULL )";

  static const String myCartTable2 =
      "CREATE TABLE IF NOT EXISTS cart2(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product_id2 TEXT NOT NULL, "
      "lens_type TEXT NOT NULL, rd_sph TEXT NOT NULL, rd_cyl TEXT NOT NULL, rd_axis TEXT NOT NULL, rd_bcva TEXT NOT NULL,"
      "ra_sph TEXT NOT NULL, ra_cyl TEXT NOT NULL, ra_axis TEXT NOT NULL, ra_bcva TEXT NOT NULL,"
  "ld_sph TEXT NOT NULL, ld_cyl TEXT NOT NULL, ld_axis TEXT NOT NULL, ld_bcva TEXT NOT NULL,"
  "la_sph TEXT NOT NULL, la_cyl TEXT NOT NULL, la_axis TEXT NOT NULL, la_bcva TEXT NOT NULL,re TEXT NOT NULL,le TEXT NOT NULL,"
  "addon_title TEXT NOT NULL, addon_price REAL NOT NULL, addon_qty INTEGER NOT NULL, addon_total REAL NOT NULL,"
      "priscription TEXT NOT NULL,frame_name TEXT NOT NULL, frame_price REAL NOT NULL, frame_qty INTEGER NOT NULL, frame_total REAL NOT NULL)";


  static const String myCartTable3=
      "CREATE TABLE IF NOT EXISTS cart3(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "product_id	TEXT NOT NULL,variant_id TEXT NOT NULL, name TEXT NOT NULL, trial_request_type TEXT NOT NULL, clinic_name TEXT NOT NULL,"
      "client_name TEXT NOT NULL, mobile TEXT NOT NULL, mail TEXT NOT NULL, house_no TEXT NOT NULL, location TEXT NOT NULL, pincode TEXT NOT NULL, address_type "
      "TEXT NOT NULL, appointment_time TEXT NOT NULL, appointment_date TEXT NOT NULL, unit_price REAL NOT NULL, quantity INTEGER NOT NULL,"
      "total REAL NOT NULL,pr_type TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, priscription2 TEXT NOT NULL)";

  late sql.Database _db;

  /// Opening database
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "infinite.db");
    _db = await sql.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(sql.Database db, int version) async {
    await db.execute(myCartTable);
    await db.execute(myCartTable2);
    await db.execute(myCartTable3);
  }

  /// Cart Table Beginning
  // Insert values to cart table
  Future<int> insertValuesIntoCartTable(Map<String, dynamic> data) async {
    int result = 0;
    result = await _db.insert('cart', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  Future<int> insertValuesIntoCartTable2(Map<String, dynamic> data) async {
    int result = 0;
    result = await _db.insert('cart2', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }
  Future<int> insertValuesIntoCartTable3(Map<String, dynamic> data) async {
    int result = 0;
    result = await _db.insert('cart3', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    debugPrint('ADDED BOOK APPOINTMENT DETAILS IN DB :  $result');
    return result;
  }

  // get all records from cart table
  Future<List<Map<String, dynamic>>> getCartList() async {
    var res = await _db.query("cart");
    debugPrint("SHOW LOCAL DB HELPER CART: $res");
    // List<CartModel> list = [];
    // if (res.isNotEmpty) {
    //   for (var d in res) {
    //     debugPrint("SHOW LOCAL DB HELPER CART 0: $d");
    //     CartModel model = CartModel();
    //     model.id = int.parse(d['id'].toString());
    //     model.productId = int.parse(d['product_id'].toString());
    //     model.variantId = int.parse(d['variant_id'].toString());
    //     model.name = d['name'].toString();
    //     model.productType = d['product_type'].toString();
    //     model.variantName = d['variant_name'].toString();
    //     model.unitPrice = d['unit_price'].toString();
    //     model.quantity = int.parse(d['quantity'].toString());
    //     model.total = double.parse(d['total'].toString());
    //     model.isSync = int.parse(d['is_sync'].toString());
    //     model.imageUrl = d['image_url'].toString();
    //     list.add(model);
    //   }
    // }
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList2() async {
    var res = await _db.query("cart2");
    debugPrint("SHOW FRAME DETAILS CART: $res");
    return res;
  }

  Future<List<Map<String, dynamic>>> getBookCartList() async {
    var res = await _db.query("cart3");
    debugPrint("SHOW BOOK APPOINTMENT DETAILS CART: $res");
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList3() async {
    return await _db.rawQuery(
        'SELECT product_id, name, image_url,unit_price,variant_name,variant_id, quantity,total,product_type,lens_type, rd_sph, rd_cyl, rd_axis, rd_bcva, ra_sph, ra_cyl, ra_axis, ra_bcva,'
            'ld_sph, ld_cyl, ld_axis, ld_bcva, la_sph, la_cyl, la_axis, la_bcva,re, le,addon_title,addon_price,inventory_quantity,'
            'priscription, frame_name, frame_price, frame_qty, frame_total, created_at,updated_at FROM cart2 INNER JOIN cart ON cart.product_id=cart2.product_id2');
  }

  // Future<List<Map<String, dynamic>>> getCartList4() async{
  //   return await _db.rawQuery('SELECT product_id,trial_request_type, clinic_name,client_name, mobile, mail, house_no, location, pincode, address_type,'
  //       'appointment_time, appointment_date FROM cart3 INNER JOIN cart ON cart.product_id=cart3.product_id3');
  // }


  // getting particular product detail in offline by is_sync value equal to 0
  Future<List<Map<String, dynamic>>> getParticularCartInOffline(
      int isSync) async {
    var res =
        await _db.query("cart", where: 'is_sync = ?', whereArgs: [isSync]);
    debugPrint('SHOW SALES ITEM TABLE RECORDS IN OFFLINE:  $res');
    return res;
  }

  // check particular product detail in is already added or not
  Future<List<Map<String, dynamic>>> getParticularCartAddedOrNot(int id,String type) async {
    //var res = await _db.query("cart", where: 'product_id = ?', whereArgs: [id]);
    var res = await _db.rawQuery('SELECT * FROM cart WHERE product_id=? and pr_type=?',[id, type]);
    debugPrint('PRODUCT ALREADY ADDED OR NOT IN TABLE OFFLINE(ORDER) ::  $res');
    return res;
  }

  Future<List<Map<String, dynamic>>> getParticularCartAddedOrNotBook(int id,String type) async {
    //var res = await _db.query("cart", where: 'product_id = ?', whereArgs: [id]);
    var res = await _db.rawQuery('SELECT * FROM cart3 WHERE product_id=? and pr_type=?',[id, type]);
    debugPrint('PRODUCT ALREADY ADDED OR NOT IN TABLE OFFLINE (BOOK) ::  $res');
    return res;
  }

  // List<Map> result = await db.rawQuery('SELECT * FROM my_table WHERE name=? and last_name=? and year=?',['Peter', 'Smith', 2019]);



  // to update a field in a table
  Future<void> updateQuantityOfProductInCart(int value, int id, double unitPrice) async {

    await _db.rawUpdate(
        "UPDATE cart SET quantity = '$value', total = '${unitPrice * value}' WHERE product_id = '$id' ");
  }
  Future<void> updateAddonProductQtyInCart(int value, int id, double unitPrice) async {
    await _db.rawUpdate(
        "UPDATE cart2 SET addon_qty = '$value', addon_total = '${unitPrice * value}' WHERE product_id2 = '$id' ");
  }



  Future<void> updateBookQuantity(int value, int id, double unitPrice) async {

    await _db.rawUpdate(
        "UPDATE cart3 SET quantity = '$value', total = '${unitPrice * value}' WHERE product_id = '$id' ");
  }

  Future<void> updateFrameQuantity2(int value,double price, int id) async {
    await _db.rawUpdate(
        "UPDATE cart2 SET frame_qty = '$value', frame_total = '${price * value}' WHERE product_id2 = '$id' ");
  }


  // get sum of total in sales item table
  Future getTotal() async {
    var result = await _db.rawQuery("SELECT SUM(total) as Total FROM cart");
    return result[0]['Total'];
  }

  Future getTotal2() async {
    var result = await _db.rawQuery("SELECT SUM(frame_total) as Total FROM cart2");
    return result[0]['Total'];
  }

  Future getAddOnTotal() async {
    var result = await _db.rawQuery("SELECT SUM(addon_total) as Total FROM cart2");
    return result[0]['Total'];
  }

  Future getBookTotal2() async {
    var result = await _db.rawQuery("SELECT SUM(total) as Total FROM cart3");
    return result[0]['Total'];
  }

  Future getBookTotal() async {
    var result = await _db.rawQuery("SELECT SUM(total3) as Total FROM cart3");
    return result[0]['Total'];
  }

  Future getFrameTotal() async {
    var result =
        await _db.rawQuery("SELECT SUM(frame_total) as Total FROM cart2");
    return result[0]['Total'];
  }

  // delete a record a sales item table by specific id
  Future<int> deleteCart(int productId) async {
    return await _db
        .delete("cart", where: 'product_id = ?', whereArgs: [productId]);
  }

  Future<int> deleteCart2(int productId) async {
    return await _db
        .delete("cart2", where: 'product_id2 = ?', whereArgs: [productId]);
  }

  Future<int> deleteCart3(int productId) async {
    return await _db
        .delete("cart3", where: 'product_id = ?', whereArgs: [productId]);
  }

  Future<int> deleteFrame(int productId) async {
    return await _db
        .delete('cart2', where: 'product_id=?', whereArgs: [productId]);
  }

  Future<int?>getTotalCartCount() async {
    final count = sql.Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM cart'));
    debugPrint('people count: $count');
    return count;
  }
  Future<int?>getTotalBookCount() async {
    final count = Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM cart3'));
    debugPrint('people count: $count');
    return count;
  }

  close() async {
    _db.close();
  }
}
