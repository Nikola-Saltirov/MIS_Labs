import 'package:shared_preferences/shared_preferences.dart';

import '../models/simple_recipe_model.dart';
import 'api_service.dart';

class FavoritesService {
  final ApiService _apiService = ApiService();

  static const _key = 'my_list';

  Future<List<String>> loadOrCreateList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<bool> isFavorite(String id) async {
    final list = await loadOrCreateList();
    return list.contains(id);
  }

  Future<void> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    if (!list.contains(id)) {
      list.add(id);
      await prefs.setStringList(_key, list);
    }
  }

  Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    list.remove(id);
    await prefs.setStringList(_key, list);
  }

  Future<List<SimpleRecipeModel>> loadMeals() async {
    final ids = await loadOrCreateList();
    List<SimpleRecipeModel> meals = [];

    for (final id in ids) {
      final meal = await _apiService.getRecipeById(id);
      if (meal == null) continue;
      meals.add(
        SimpleRecipeModel(
          id: meal.id,
          title: meal.title,
          thumbnail: meal.thumbnail,
        ),
      );
    }

    return meals;
  }
}
