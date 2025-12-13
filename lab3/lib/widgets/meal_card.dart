import 'package:flutter/material.dart';
import 'package:lab2/services/favorites_service.dart';
import '../models/simple_recipe_model.dart';
import '../screens/recipe_details.dart';

class MealCard extends StatefulWidget {
  final SimpleRecipeModel meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final FavoritesService _favoritesService = FavoritesService();

  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = _favoritesService.isFavorite(widget.meal.id);
  }

  Future<void> _toggleFavorite() async {
    final isFav = await _favoritesService.isFavorite(widget.meal.id);

    if (isFav) {
      await _favoritesService.removeFavorite(widget.meal.id);
    } else {
      await _favoritesService.addFavorite(widget.meal.id);
    }

    setState(() {
      _isFavoriteFuture =
          _favoritesService.isFavorite(widget.meal.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailedRecipe(recipeId: widget.meal.id),
          ),
        );
      },
      child: Card(
        color: Colors.lightGreen.shade100,
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green.shade200, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.meal.thumbnail,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.meal.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              FutureBuilder<bool>(
                future: _isFavoriteFuture,
                builder: (context, snapshot) {
                  final isFavorite = snapshot.data ?? false;

                  return IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.greenAccent,
                    ),
                    onPressed: _toggleFavorite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
