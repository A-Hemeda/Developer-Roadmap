import '../models/zekr_model.dart';
import '../database/database_helper.dart';
import 'package:flutter/foundation.dart';

class AzkarProvider with ChangeNotifier {
  final List<ZekrModel> _azkar = <ZekrModel>[];
  DatabaseHelper databaseHelper = DatabaseHelper();

  String get table => 'azkar';

  int get length => _azkar.length;

  ZekrModel getZekr(int index) {
    return _azkar[index];
  }

  Future<bool> initialAllAzkar(String azkarIndex) async {
    try {
      _azkar.clear();
      List<Map<String, dynamic>> tempAzkar =
          await databaseHelper.getData(table, azkarIndex);
      debugPrint('tempAzkar.length : ${tempAzkar.length}');

      for (int i = 0; i < tempAzkar.length; i++) {
        _azkar.add(ZekrModel.fromMap(tempAzkar[i]));
      }

      debugPrint('_azkar.length : ${_azkar.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllAzkar');
      debugPrint('e : $e');
      return false;
    }
  }
}
