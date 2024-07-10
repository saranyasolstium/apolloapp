
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
class DBHelper2 {
  // creating sales table
  static const String myCartTable =
      "CREATE TABLE IF NOT EXISTS cart(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "product_id	TEXT NOT NULL,variant_id	TEXT NOT NULL,product_name TEXT NOT NULL,product_type TEXT NOT NULL,"
      "variant_name TEXT NOT NULL,unit_price REAL NOT NULL,quantity INTEGER NOT NULL,total REAL NOT NULL,"
     "image_url TEXT NOT NULL,inventory_quantity INTEGER NOT NULL, created_at TEXT NOT NULL,"
      "updated_at TEXT NOT NULL )";

  static const String myCartTable2 =
      "CREATE TABLE IF NOT EXISTS cart2(frame_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product_id TEXT NOT NULL,"
      "lens_type TEXT NOT NULL, product_title TEXT NOT NULL,rd_sph TEXT NOT NULL, rd_cyl TEXT NOT NULL, rd_axis TEXT NOT NULL, rd_bcva TEXT NOT NULL,"
      "ra_sph TEXT NOT NULL, ra_cyl TEXT NOT NULL, ra_axis TEXT NOT NULL, ra_bcva TEXT NOT NULL,"
      "ld_sph TEXT NOT NULL, ld_cyl TEXT NOT NULL, ld_axis TEXT NOT NULL, ld_bcva TEXT NOT NULL,"
      "la_sph TEXT NOT NULL, la_cyl TEXT NOT NULL, la_axis TEXT NOT NULL, la_bcva TEXT NOT NULL,re TEXT NOT NULL,le TEXT NOT NULL,"
      "priscription TEXT NOT NULL,frame_name TEXT NOT NULL, frame_price REAL NOT NULL, frame_qty INTEGER NOT NULL, frame_total REAL NOT NULL,"
      "created_at TEXT NOT NULL, updated_at TEXT NOT NULL)";

  static const String myCartTable3=
      "CREATE TABLE IF NOT EXISTS cart3(book_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "product_id	TEXT NOT NULL,variant_id TEXT NOT NULL, name TEXT NOT NULL, trial_request_type TEXT NOT NULL, clinic_name TEXT NOT NULL,"
      "client_name TEXT NOT NULL, mobile TEXT NOT NULL, mail TEXT NOT NULL, house_no TEXT NOT NULL, location TEXT NOT NULL, pincode TEXT NOT NULL, address_type "
      "TEXT NOT NULL, appointment_time TEXT NOT NULL, appointment_date TEXT NOT NULL, book_price REAL NOT NULL, book_qty INTEGER NOT NULL,"
      "book_total REAL NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, priscription TEXT NOT NULL, relation TEXT NOT NULL)";

  static const String myCartTable4=
      "CREATE TABLE IF NOT EXISTS cart4(addon_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "product_id	TEXT NOT NULL,addon_title TEXT NOT NULL, addon_price REAL NOT NULL, addon_qty INTEGER NOT NULL, addon_total REAL NOT NULL,"
      "created_at TEXT NOT NULL, updated_at TEXT NOT NULL)";

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
    await db.execute(myCartTable4);

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
    return result;
  }
  Future<int> insertValuesIntoCartTable4(Map<String, dynamic> data) async {
    int result = 0;
    result = await _db.insert('cart4', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }



  // get all records from cart table
  Future<List<Map<String, dynamic>>> getCartList() async {
    var res = await _db.query("cart");
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList2() async {
    var res = await _db.query("cart2");
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList3() async {
    var res = await _db.query("cart3");
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList4() async {
    var res = await _db.query("cart4");
    return res;
  }

  Future<List<Map<String, dynamic>>> getCartList5() async {
    var res = await _db.query("cart4");
    debugPrint("SHOW ADD ON DETAILS CART (NEW): $res");
    return res;
  }

  Future<List<Map<String, dynamic>>> getParticularCartAddedOrNot(int id) async {
    var res = await _db.rawQuery('SELECT * FROM cart WHERE variant_id=?',[id]);
    debugPrint('PRODUCT ALREADY ADDED OR NOT IN TABLE OFFLINE(ORDER) ::  $res');
    return res;
  }

  Future<List<Map<String, dynamic>>> getAddOnAddedOrNot() async {
    var res = await _db.rawQuery('SELECT * FROM cart4 ');
    debugPrint('ADD ON PRODUCT ALREADY ADDED OR NOT IN TABLE ::  $res');
    return res;
  }



  Future<void> updateQuantityOfProductInCart(int value, int id, double unitPrice) async {

    await _db.rawUpdate(
        "UPDATE cart SET quantity = '$value', total = '${unitPrice * value}' WHERE product_id = '$id' ");
  }


  Future<void> updateAddOn(int id,int value) async {

    await _db.rawUpdate(
        "UPDATE cart4 SET addon_qty = '$value' WHERE addon_id = '$id' ");
  }
  Future<void> updateAddOnNew(int value) async {

    await _db.rawUpdate(
        "UPDATE cart4 SET addon_qty = '$value' WHERE addon_id = ? ");
  }


//UPDATE ADDON TOTAL
  Future<void> updateAddOnTotal(int qty, int id, double unitPrice) async {
    await _db.rawUpdate("UPDATE cart4 SET addon_qty = '$qty', addon_total = '${unitPrice * qty}' WHERE addon_id = '$id' ");
  }

  Future<void> updateQuantityOfProductInCart2(int value, int frameId, double unitPrice, int productId) async {
    await _db.rawUpdate(
        "UPDATE cart2 SET frame_qty = '$value', frame_total = '${unitPrice * value}' WHERE frame_id = ? AND product_id = ? ",[frameId,productId]);
  }

  Future<void> updateQuantityOfProductInCart3(int value, int bookId,double bookPrice, int productId) async {
    await _db.rawUpdate(
        "UPDATE cart3 SET book_qty = '$value', book_total = '${bookPrice * value}' WHERE book_id = ? AND product_id = ? ", [bookId,productId]);

  }
  Future<void> updateQuantityOfProductInCart4(int value, int addonId, double addonPrice, int productId) async {
    await _db.rawUpdate(
        "UPDATE cart4 SET addon_qty = '$value', addon_total = '${addonPrice * value}' WHERE addon_id = ? AND product_id = ? ", [addonId,productId]);
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
  Future getTotal3() async {
    var result = await _db.rawQuery("SELECT SUM(book_total) as Total FROM cart3");
    return result[0]['Total'];
  }
  Future getTotal4() async {
    var result = await _db.rawQuery("SELECT SUM(addon_total) as Total FROM cart4");
    return result[0]['Total'];
  }
  Future getTotalQty4() async {
    var result = await _db.rawQuery("SELECT SUM(addon_qty) as Total FROM cart4");
    return result[0]['Total'];
  }

  Future<dynamic> getTotalOrderCount() async {
    var result = await _db.rawQuery("SELECT SUM(quantity) as Total FROM cart");
    return result[0]['Total'];
  }
  Future<dynamic> getTotalFrameCount() async {
    var result = await _db.rawQuery("SELECT SUM(frame_qty) as Total FROM cart2");
    return result[0]['Total'];
  }
  Future<dynamic> getTotalBookCount() async {
    var result = await _db.rawQuery("SELECT SUM(book_qty) as Total FROM cart3");
    return result[0]['Total'];
  }
  Future<dynamic> getTotalAddOnCount() async {
    var result = await _db.rawQuery("SELECT SUM(addon_qty) as Total FROM cart4");
    return result[0]['Total'];
  }


  // delete a record a sales item table by specific id
  Future<int> deleteCart(int productId) async {
    return await _db
        .delete("cart", where: 'product_id = ?', whereArgs: [productId]);
  }

  Future<int> deleteCart2(int autoIncId) async {
    return await _db
        .delete("cart2", where: 'frame_id = ?', whereArgs: [autoIncId]);
  }

  Future<int> deleteCart3(int productId) async {
    return await _db
        .delete("cart3", where: 'book_id = ?', whereArgs: [productId]);
  }

  Future<int> deleteCart4(int productId) async {
    return await _db
        .delete('cart4', where: 'addon_id=?', whereArgs: [productId]);
  }

  Future<int?>getTotalCartCount() async {
    final count = sql.Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM cart'));
    debugPrint('people count: $count');
    return count;
  }

  // Future<int?>getTotalBookCount() async {
  //   final count = sql.Sqflite.firstIntValue(
  //       await _db.rawQuery('SELECT COUNT(*) FROM cart2'));
  //   debugPrint('people count: $count');
  //   return count;
  // }
  //




  close() async {
    _db.close();
  }
}