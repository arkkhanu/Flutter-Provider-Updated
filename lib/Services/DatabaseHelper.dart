import 'dart:io';
import 'package:flutter_sqlife_and_provider/Model/City.dart';
import 'package:flutter_sqlife_and_provider/Model/Currency.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 2;

  static final _table1 = 'Cities';
  static final _table2 = 'Currency';


  static Database _database;

  static Future<Database> init() async {
    if (_database != null)
      return _database;
    else {
      _database = await _initDatabase();
      return _database;
    }
  }

  // this opens the database (and creates it if it doesn't exist)
  static _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {

    /*
    *   Cities
    * */
    await db.execute('''
          CREATE TABLE $_table1 (
            dbId INTEGER PRIMARY KEY AUTOINCREMENT,
            ID TEXT,
            CityName TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $_table2 (
            dbId INTEGER PRIMARY KEY AUTOINCREMENT,
            ID TEXT,
            CurrencyName TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  /*static Future<int> insert(Map<String, dynamic> row) async {
    return await _database.insert(_table1, row);
  }*/

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  /*static Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _database.query(_table1);
  }*/

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  /*Future<int> queryRowCount() async {
    return Sqflite.firstIntValue(
        await _database.rawQuery('SELECT COUNT(*) FROM $_table1'));
  }*/

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  /*Future<int> update(Map<String, dynamic> row) async {
    int id = row[_columnId];
    return await _database
        .update(_table1, row, where: '$_columnId = ?', whereArgs: [id]);
  }*/

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  /*Future<int> delete(int id) async {
    return await _database
        .delete(_table1, where: '$_columnId = ?', whereArgs: [id]);
  }*/

  /*
  *   Cities
  * */
  static Future<int> insertCities(City city) async {
    final row = city.toJson();
    print("row:"+row.toString());
    return await _database.insert(_table1, row);
  }

  static Future<List<City>> getAllCities() async {
    return await _database.query(_table1).then(
            (value) =>
            value.map((e) => City.fromJson(e)).toList());
  }


  static Future deleteAllCities(){
    return _database.delete(_table1);
  }


  /*
  * Currency
  * */
  static Future<int> insertCurrency(Currency currency) async {
    final row = currency.toJson();
    print("row:"+row.toString());
    return await _database.insert(_table2, row);
  }

  static Future<List<Currency>> getAllCurrencies() async {
    return await _database.query(_table2).then(
            (value) =>
            value.map((e) => Currency.fromJson(e)).toList());
  }


  static Future deleteAllCurrencies(){
    return _database.delete(_table2);
  }

}
