import '../models/prayer_model.dart';
import '../database/database_helper.dart';
import 'package:flutter/foundation.dart';

class PrayerProvider with ChangeNotifier {
  final List<PrayerModel> _prayer = <PrayerModel>[];
  final Map<String, List<int>> _prayerGuide = <String, List<int>>{};
  DatabaseHelper databaseHelper = DatabaseHelper();

  String get table => 'prayer';

  int get length => _prayer.length;

  List<String> get allSurah => _prayerGuide.keys.toList();

  PrayerModel getPrayer(int index) {
    return _prayer[index];
  }

  List<int> getAyatSurah(String surah) {
    return _prayerGuide[surah];
  }

  int getAyaOfSurah(String surah, int index) {
    return _prayerGuide[surah][index];
  }

  Future<bool> updateFavorite(int favorite, int id) async {
    _prayer[id].setFavorite(favorite);
    try {
      await databaseHelper.updateFavoriteInTables('prayer', favorite, id);
      debugPrint('uptadeFavorite : true');
      return true;
    } catch (e) {
      debugPrint('uptadeFavorite e : $e');
      return false;
    }
  }

  Future<bool> initialAllPrayer() async {
    try {
      List<Map<String, dynamic>> tempPrayer =
          await databaseHelper.getData(table, '-1');
      debugPrint('tempPrayer.length : ${tempPrayer.length}');

      String nameSurah = tempPrayer[0]['surah'];
      _prayerGuide[nameSurah] = <int>[];
      for (int i = 0; i < tempPrayer.length; i++) {
        _prayer.add(PrayerModel.fromMap(tempPrayer[i]));

        String tempNameSurah = _prayer[i].surah;
        if (nameSurah != tempNameSurah) {
          _prayerGuide[tempNameSurah] = <int>[];
          nameSurah = tempNameSurah;
        }
        _prayerGuide[tempNameSurah].add(_prayer[i].id);
      }

      debugPrint('_prayer.length : ${_prayer.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllPrayer');
      debugPrint('e : $e');
      return false;
    }
  }
}
