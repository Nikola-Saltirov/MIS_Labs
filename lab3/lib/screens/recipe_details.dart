import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/detailed_recipe_model.dart';
import '../services/api_service.dart';

class DetailedRecipe extends StatefulWidget {
  final String recipeId;

  const DetailedRecipe({super.key, required this.recipeId});

  @override
  State<DetailedRecipe> createState() => _DetailedRecipe();
}

void _openLink(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _DetailedRecipe extends State<DetailedRecipe> {
  late final DetailedRecipeModel _recipe;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadRecipeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.lightGreen.shade200,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _recipe.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    _recipe.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () => _openLink(_recipe.link),
                    child: Text(
                      "Check it out on YouTube",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Ingredients:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ..._recipe.ingredients.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text("• $item", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Instructions:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _recipe.instructions,
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _loadRecipeDetails() async {
    final DetailedRecipeModel? recipe;
    if (widget.recipeId.isEmpty) {
      recipe = await _apiService.getRandomRecipe();
    } else {
      recipe = await _apiService.getRecipeById(widget.recipeId);
    }
    setState(() {
      if (recipe != null) {
        _recipe = recipe;
        _isLoading = false;
      }
    });
  }
}
