import '../database/database_helper.dart';
import '../models/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier {
  final List<CategoryModel> _categories = <CategoryModel>[];
  DatabaseHelper databaseHelper = DatabaseHelper();

  String get table => 'categories';

  int get length => _categories.length;

  CategoryModel getCategory(int index) {
    return _categories[index];
  }

  List<String> get allCategoriesName {
    List<String> tempList = <String>[];
    for (int i = 0; i < length; i++) {
      tempList.add(_categories[i].nameWithoutDiacritics);
    }
    return tempList;
  }

  Future<bool> updateFavorite(int favorite, int id) async {
    _categories[id].setFavorite(favorite);
    try {
      await databaseHelper.updateFavoriteInTables('categories', favorite, id);
      debugPrint('uptadeFavorite : true');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('uptadeFavorite e : $e');
      return false;
    }
  }

  Future<bool> initialAllCategories() async {
    try {
      List<Map<String, dynamic>> tempCategories =
          await databaseHelper.getData(table, '-1');
      debugPrint('tempCategories.length : ${tempCategories.length}');

      for (int i = 0; i < tempCategories.length; i++) {
        _categories.add(CategoryModel.fromMap(tempCategories[i]));
      }

      debugPrint('_categories.length : ${_categories.length}');
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Faild initialAllCategories');
      debugPrint('e : $e');
      return false;
    }
  }
}
