// ignore_for_file: depend_on_referenced_packages

import 'package:login_screen_homework/data/models/map/map_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      'addresses.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE addresses (
          id INTEGER PRIMARY KEY,
          name TEXT,
          latitude REAL,
          longitude REAL,
          title TEXT
        )
      ''');
      },
    );
  }


  static Future<void> insertAddress(Address address) async {
    await _database.insert('addresses', address.toJson());
  }

  static Future<List<Address>> getAddresses() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query('addresses');

    return List.generate(maps.length, (i) {
      return Address.fromJson(maps[i]);
    });
  }


  static Future<void> deleteAddress(int id) async {
    final db = _database;
    await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAllAddresses() async {
    final db = _database;
    await db.delete('addresses');
  }

  static Future<void> updateAddress(Address updatedAddress) async {
    final db =  _database;
    await db.update(
      'addresses',
      updatedAddress.toJson(),
      where: 'id = ?',
      whereArgs: [updatedAddress.id],
    );
  }
}
