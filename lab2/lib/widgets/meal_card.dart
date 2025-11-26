import 'package:flutter/material.dart';
import 'package:lab2/models/simple_recipe_model.dart';
import '../screens/recipe_details.dart';


class MealCard extends StatelessWidget {
  final SimpleRecipeModel Meal;

  const MealCard({super.key, required this.Meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedRecipe(recipeId: Meal.id),
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
            mainAxisSize: MainAxisSize.min, // allow card height to grow
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  Meal.thumbnail,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                Meal.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
