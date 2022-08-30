import '../database/database_helper.dart';
import '../models/sebha_model.dart';
import 'package:flutter/foundation.dart';

class SebhaProvider with ChangeNotifier {
  final List<SebhaModel> _sebha = <SebhaModel>[];
  DatabaseHelper databaseHelper = DatabaseHelper();

  String get table => 'tasbih';

  int get length => _sebha.length;

  int get newId => _sebha.isEmpty ? 0 : _sebha[length - 1].id + 1;

  SebhaModel getItemSebha(int index) {
    return _sebha[index];
  }

  SebhaModel getItemSebhaById(int id) {
    return _sebha.firstWhere((item) => id == item.id);
  }

  Future<bool> addItemToSebha(SebhaModel item) async {
    try {
      await databaseHelper.insert(table, item.toMap()); //addItemToSebha(item);
      _sebha.add(item);
      debugPrint('addItemToSebha');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild addItemToSebha');
      debugPrint('e : $e');
      return false;
    }
  }

  Future<bool> updateItemFromSebha(SebhaModel item) async {
    try {
      await databaseHelper.updateItemFromSebha(item);
      debugPrint('updateItemFromSebha');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild updateItemFromSebha');
      debugPrint('e : $e');
      return false;
    }
  }

  Future<bool> deleteItemFromSebha(int itemId) async {
    try {
      await databaseHelper.delete(
          table: table, id: itemId); //.deleteItemFromSebha(itemId);

      for (int i = 0; i < length; i++) {
        if (_sebha[i].id == itemId) {
          _sebha.removeAt(i);
          break;
        }
      }

      debugPrint('deleteItemFromSebha');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild deleteItemFromSebha');
      debugPrint('e : $e');
      return false;
    }
  }

  Future<bool> updateFavorite(int favorite, int id, int indexInList) async {
    try {
      await databaseHelper.updateFavoriteInTables(table, favorite, id);
      _sebha[indexInList].setFavorite(favorite);
      debugPrint('updateFavorite : true');
      return true;
    } catch (e) {
      debugPrint('updateFavorite e : $e');
      return false;
    }
  }

  Future<bool> initialAllItemsOfSebha() async {
    try {
      List<Map<String, dynamic>> tempSebha =
          await databaseHelper.getData(table, '-1');
      debugPrint('tempSebha.length : ${tempSebha.length}');

      for (int i = 0; i < tempSebha.length; i++) {
        _sebha.add(SebhaModel.fromMap(tempSebha[i]));
      }

      debugPrint('_sebha.length : ${_sebha.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllItemsOfSebha');
      debugPrint('e : $e');
      return false;
    }
  }
}
