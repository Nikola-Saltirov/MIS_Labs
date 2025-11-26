class CategoryModel {
  String id;
  String title;
  String thumbnail;
  String description;


  CategoryModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["idCategory"],
      title: json["strCategory"],
      thumbnail: json["strCategoryThumb"],
      description: json["strCategoryDescription"],
    );
  }



}
