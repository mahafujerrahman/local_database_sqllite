import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      // Get the default database path
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'cart.db');

      // Open the database
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE cart (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              price REAL,
              quantity INTEGER
            )
          ''');
        },
      );
    } catch (e) {
      print('Database initialization error: $e');
      rethrow;
    }
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('cart', row);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    Database db = await instance.database;
    return await db.query('cart');
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('cart', row, where: 'id = ?', whereArgs: [id]);
  }
}
