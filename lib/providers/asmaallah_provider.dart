import '../models/asmaallah_model.dart';
import '../database/database_helper.dart';
import 'package:flutter/foundation.dart';

class AsmaAllahProvider with ChangeNotifier {
  final List<AsmaAllahModel> _asmaallah = <AsmaAllahModel>[];
  DatabaseHelper databaseHelper = DatabaseHelper();

  String get table => 'asmaallah';

  int get length => _asmaallah.length;

  AsmaAllahModel getAsmaAllah(int index) {
    return _asmaallah[index];
  }

  List<String> get allAmaAllah {
    List<String> tempList = <String>[];
    for (int i = 0; i < length; i++) {
      tempList.add(_asmaallah[i].name);
    }
    return tempList;
  }

  Future<bool> initialAllAsmaAllah() async {
    try {
      List<Map<String, dynamic>> tempAsmaallah =
          await databaseHelper.getData(table, '-1');

      for (int i = 0; i < tempAsmaallah.length; i++) {
        _asmaallah.add(AsmaAllahModel.fromMap(tempAsmaallah[i]));
      }

      debugPrint('_asmaallah.length : ${_asmaallah.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllAsmaAllah');
      debugPrint('e : $e');
      return false;
    }
  }
}
