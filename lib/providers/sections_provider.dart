import 'package:azkark/providers/settings_provider.dart';
import '../database/database_helper.dart';
import '../models/section_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'asmaallah_provider.dart';
import 'categories_provider.dart';
import 'favorites_provider.dart';
import 'prayer_provider.dart';
import 'sebha_provider.dart';

class SectionsProvider with ChangeNotifier {
  final List<SectionModel> _sections = <SectionModel>[];
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool _newUser = true;

  bool get isNewUser => _newUser;

  String get table => 'sections';

  int get length => _sections.length;

  SectionModel getSection(int index) {
    return _sections[index];
  }

  List<int> getCategoriesIndex(int id) {
    return _sections[id].categoriesIndex;
  }

  Future<bool> initialAllSections() async {
    try {
      List<Map<String, dynamic>> tempSections =
          await databaseHelper.getData(table, '-1');
      debugPrint('tempSections.length : ${tempSections.length}');

      for (int i = 0; i < tempSections.length; i++) {
        _sections.add(SectionModel.fromMap(tempSections[i]));
      }

      debugPrint('_sections.length : ${_sections.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllSections');
      debugPrint('e : $e');
      return false;
    }
  }

  Future<bool> tryToGetData(BuildContext context) async {
    bool doesUserExists = await databaseHelper.isFileExists();

    if (doesUserExists) {
      debugPrint('_newUser = false');
      _newUser = false;
      return false;
    }

    _newUser = true;
    debugPrint('tryToGetData _newUser = true');
    notifyListeners();

    await initialAllSections();
    debugPrint('initialAllSections');
    try {
      await Provider.of<SettingsProvider>(context, listen: false)
          .initialSettings();
      await Provider.of<CategoriesProvider>(context, listen: false)
          .initialAllCategories();
      await Provider.of<SebhaProvider>(context, listen: false)
          .initialAllItemsOfSebha();
      await Provider.of<FavoritesProvider>(context, listen: false)
          .initialAllFavorites();
      await Provider.of<PrayerProvider>(context, listen: false)
          .initialAllPrayer();
      await Provider.of<AsmaAllahProvider>(context, listen: false)
          .initialAllAsmaAllah();
      debugPrint('initialAll Categories, AllItemsOfSebha, AllFavorites, AllPrayer');
    } catch (e) {
      debugPrint('_initial e  : $e');
    }
    return true;
  }
}
