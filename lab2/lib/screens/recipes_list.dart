import 'package:flutter/material.dart';

import '../models/simple_recipe_model.dart';
import '../services/api_service.dart';
import '../widgets/meal_list.dart';

class RecipeList extends StatefulWidget {
  final String category;

  const RecipeList({super.key, required this.category});

  @override
  State<RecipeList> createState() => _RecipeList();
}

class _RecipeList extends State<RecipeList> {
  bool _isLoading = true;
  late final List<SimpleRecipeModel> _meals;
  List<SimpleRecipeModel> _filteredMeals = [];
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMealList(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade200,
        title: Text("Recipe List for " + widget.category),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for Category...',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _searchMealByName(value);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: _filteredMeals.isEmpty
                        ? Text(
                            "No meals with category " +
                                widget.category.toString() +
                                " found!",
                          )
                        : MealGrid(meals: _filteredMeals),
                  ),
                ),
              ],
            ),
    );
  }

  void _loadMealList(String category) async {
    final meals = await _apiService.loadMealList(category);
    setState(() {
      _meals = meals;
      _filteredMeals = _meals;
      _isLoading = false;
    });
  }

  void _searchMealByName(String query) async {
    List<SimpleRecipeModel>? temp;

    if (query.isEmpty) {
      temp = _meals;
    } else {
      temp = await _apiService.searchMeals(widget.category, query);
    }

    setState(() {
      _filteredMeals = temp!;
      _isLoading = false;
    });
  }
}
