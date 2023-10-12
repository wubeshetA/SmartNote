import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';

class SqliteDatabaseHelper {
  static Database? _database;

  final dbName = 'smartnote.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = documentsDirectory.path + dbName;
    print("==============================Database Path: $path");

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE paths (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        notes TEXT NOT NULL,
        questions TEXT NOT NULL,
        title TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

      )
    ''');
  }

  Future<int> insertPath(Map<String, dynamic> path) async {
    Database db = await database;
    return await db.insert('paths', path).onError((error, stackTrace) {
      print("================== Error in inserting path: ====================");
      print(error);
      return -1;
    });
  }

  Future<int> deletePath(int id) async {
    Database db = await database;
    return await db.delete(
      'paths',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getPaths() async {
    Database db = await database;
    return await db.query('paths');
  }
}


// examples on how to use the above functions

// void main() async {
//   var dbHelper = SqliteDatabaseHelper();

//   // Insert data
//   var id = await dbHelper.insertPath({
//     'notes': 'Note 1',
//     'questions': 'Question 1',
//     'title': 'Title 1',
//   });

// //   // Delete data
// //   // var rowsDeleted = await dbHelper.deletePath(id);

// //   // Get all paths
//   var paths = await dbHelper.getPaths();
//   // iterate over the list and print each path
//   paths.forEach((path) {
//     // call the read file function for each path
//     // both question and 
//   });
// }
