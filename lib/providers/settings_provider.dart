import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper.dart';
import '../models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  SettingsModel _settings;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int value = 1;

  void azanSound(int val) {
    value = int.parse(val.toString());
    notifyListeners();
  }

  String get table => 'settings';

  String val = 'a.mp3';

  Future save_data(String vall,int radioId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('status', vall);
    value = radioId;
    notifyListeners();
  }

  Future get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    val = prefs.getString('status') ?? 'a.mp3';

    return prefs.getBool('status');
  }

  dynamic getsettingField(String nameField) {
    switch (nameField) {
      case 'counter':
        return _settings.counter == 1 ? true : false;

      case 'diacritics':
        return _settings.diacritics == 1 ? true : false;

      case 'sanad':
        return _settings.sanad == 1 ? true : false;

      case 'font_family':
        return _settings.fontFamily;

      case 'font_size':
        return _settings.fontSize;
    }
    return _settings;
  }

  Future<bool> updateSettings(String nameField, dynamic value) async {
    debugPrint(' updateSettings $nameField');
    switch (nameField) {
      case 'counter':
        _settings.setCounter(value);
        break;

      case 'diacritics':
        _settings.setDiacritics(value);
        break;

      case 'sanad':
        _settings.setSanad(value);
        break;

      case 'font_family':
        _settings.setFontFamily(value);
        break;

      case 'font_size':
        _settings.setFontSize(value);
        break;
    }

    try {
      await databaseHelper.updateSettings(nameField, value);
      debugPrint('updateField : true');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('updateField e : $e');
      return false;
    }
  }

  Future<bool> initialSettings() async {
    try {
      List<Map<String, dynamic>> tempSettings =
          await databaseHelper.getData(table, '-1');
      debugPrint('tempSettings.length : ${tempSettings.length}');

      _settings = SettingsModel.fromMap(tempSettings[0]);

      debugPrint('_settings.length : $_settings');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialSettings');
      debugPrint('e : $e');
      return false;
    }
  }
}
