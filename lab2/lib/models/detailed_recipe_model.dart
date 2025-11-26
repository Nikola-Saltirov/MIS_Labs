class DetailedRecipeModel {
  String id;
  String title;
  String thumbnail;
  String instructions;
  List<String> ingredients;
  String link;

  DetailedRecipeModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
    required this.link,
  });

  DetailedRecipeModel.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        title = data['strMeal'],
        thumbnail = data['strMealThumb'],
        instructions = data['strInstructions'],
        ingredients = _getIngredients(data),
        link = data['strYoutube'];

  static List<String> _getIngredients(Map<String, dynamic> data) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i']?.toString().trim();
      final measure = data['strMeasure$i']?.toString().trim();

      if (ingredient == null ||
          ingredient.isEmpty ||
          ingredient.toLowerCase() == "null") {
        continue;
      }

      final safeMeasure = (measure == null ||
          measure.isEmpty ||
          measure.toLowerCase() == "null")
          ? ""
          : measure.toLowerCase();

      ingredients.add("$ingredient $safeMeasure".trim());
    }

    return ingredients;
  }
}