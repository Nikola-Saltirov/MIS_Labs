import 'package:lab2/screens/recipes_list.dart';
import 'package:lab2/services/favorites_service.dart';

import '../screens/recipe_details.dart';
import '../models/category_model.dart';
import 'package:flutter/material.dart';
import '../widgets/category_list.dart';

import '../services/api_service.dart';
import 'favorites.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  late final List<CategoryModel> _categories;
  List<CategoryModel> _filteredCategories = [];
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade200,
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> FavoritesScreen()
                ),
              );
            },
            child: const Text(
              "Favorites!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedRecipe(recipeId: ""),
                ),
              );
            },
            child: const Text(
              "Random!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
                      _searchCategoryByName(value);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: _filteredCategories.isEmpty
                        ? Text("No Categories Found!")
                        : CategoryList(categories: _filteredCategories),
                  ),
                ),
              ],
            ),
    );
  }

  void _loadCategoryList() async {
    final categories = await _apiService.loadCategoryList();

    setState(() {
      _categories = categories;
      _filteredCategories = _categories;
      _isLoading = false;
    });
  }

  void _searchCategoryByName(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (category) =>
                  category.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }
}
