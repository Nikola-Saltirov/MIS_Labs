import 'package:lab2/services/favorites_service.dart';
import 'package:flutter/material.dart';
import '../models/simple_recipe_model.dart';
import '../widgets/meal_list.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();

  late Future<List<SimpleRecipeModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = _favoritesService.loadMeals();
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      _loadFavorites();
    });
    await _favoritesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: FutureBuilder<List<SimpleRecipeModel>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshFavorites,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("No favorites yet")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshFavorites,
            child: MealGrid(meals: snapshot.data!),
          );
        },
      ),
    );
  }
}



