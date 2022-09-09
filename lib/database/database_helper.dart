import 'dart:io';
import 'package:azkark/models/sebha_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initialDatabase();
    return _database;
  }

  Future<bool> isFileExists() async {
    if (_database != null) return true;

    _database = await initialDatabase();
    return false;
  }

  Future<Database> initialDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database.db');
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets', 'database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    }
    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getData(String table, String ids) async {
    var dbClient = await database;
    String sqlCommand;
    if (ids == '-1') {
      sqlCommand = 'SELECT * FROM $table';
    } else {
      sqlCommand = 'SELECT * FROM $table WHERE id IN ($ids)';
    }

    List<Map<String, dynamic>> result = await dbClient.rawQuery(sqlCommand);

    debugPrint('getData $table done : ${result.length} ');
    return result;
  }

  Future<int> insert(String table, Map<String, dynamic> map) async {
    var dbClient = await database;
    int result = await dbClient.insert(table, map);
    debugPrint('addFavorite : $result');
    return result;
  }

  Future<int> delete(
      {@required String table,
      String tableField = 'id',
      @required int id}) async {
    var dbClient = await database;
    int result =
        await dbClient.delete(table, where: '$tableField = ?', whereArgs: [id]);

    debugPrint('delete done : $result ');
    return result;
  }

  Future<int> updateItemFromSebha(SebhaModel sebha) async {
    var dbClient = await database;
    int result = await dbClient.rawUpdate(
        'UPDATE tasbih SET name = ? , counter = ? WHERE id = ${sebha.id}',
        [sebha.name, sebha.counter]);
    debugPrint('addFavorite : $result');
    return result;
  }

  Future<int> updateFavoriteInTables(
      String tableName, int favorite, int id) async {
    var dbClient = await database;
    int result = await dbClient
        .rawUpdate('UPDATE $tableName SET favorite=$favorite WHERE id=$id');

    debugPrint('uptadeFavoriteIn $tableName : $result');
    return result;
  }

  Future<int> updateSettings(String nameField, dynamic value) async {
    var dbClient = await database;
    int result = await dbClient
        .rawUpdate('UPDATE settings SET $nameField=$value WHERE id=0');

    debugPrint('updateSettings : $result');
    return result;
  }
}
