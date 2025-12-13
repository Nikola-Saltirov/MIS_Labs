class SimpleRecipeModel {
  String id;
  String title;
  String thumbnail;


  SimpleRecipeModel({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  factory SimpleRecipeModel.fromJson(Map<String, dynamic> json) {
    return SimpleRecipeModel(
      id: json["idMeal"],
      title: json["strMeal"],
      thumbnail: json["strMealThumb"],
    );
  }



}
