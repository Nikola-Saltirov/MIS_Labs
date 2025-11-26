import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:lab2/models/detailed_recipe_model.dart';
import 'package:lab2/models/simple_recipe_model.dart';

import '../models/category_model.dart';

class ApiService {
  Future<List<CategoryModel>> loadCategoryList() async {
    List<CategoryModel> CategoryList = [];
    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );
    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      final List<dynamic> categoriesJson = detailData["categories"];

      return categoriesJson
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
    }

    return CategoryList;
  }

  Future<List<CategoryModel>> loadFilteredMealList(String filter) async {
    List<CategoryModel> CategoryList = [];
    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );
    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      final List<dynamic> categoriesJson = detailData["categories"];

      return categoriesJson
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
    }

    return CategoryList;
  }

  Future<List<SimpleRecipeModel>> loadMealList(String category) async {
    List<SimpleRecipeModel> MealList = [];
    final detailResponse = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      ),
    );
    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      final List<dynamic> mealsJson = detailData["meals"];

      return mealsJson
          .map((mealJson) => SimpleRecipeModel.fromJson(mealJson))
          .toList();
    }
    return MealList;
  }

  Future<DetailedRecipeModel?> getRecipeById(String recipeId) async {
    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeId',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['meals'][0];
      return DetailedRecipeModel.fromJson(data);
    }
  }

  Future<DetailedRecipeModel?> getRandomRecipe() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['meals'][0];
      return DetailedRecipeModel.fromJson(data);
    }
  }

  Future<List<SimpleRecipeModel>?> searchMeals(String category, String query,) async {
    List<SimpleRecipeModel> temp = [];
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['meals'];

      for (var i = 0; i < data.length; i++) {
        if (data[i]['strCategory'] == category) {
          temp.add(SimpleRecipeModel.fromJson(data[i]));
        }
      }
      return temp;
    }
  }
}
