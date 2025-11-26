import 'package:flutter/material.dart';
import 'package:lab2/models/simple_recipe_model.dart';

import 'package:dynamic_height_list_view/dynamic_height_view.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<SimpleRecipeModel> meals;
  const MealGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      itemCount: meals.length,
      builder: (context, index) {
        return MealCard(Meal: meals[index]);
      },
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }
}
