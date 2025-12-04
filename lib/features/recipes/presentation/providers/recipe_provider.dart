import 'package:flutter/material.dart';
import '../../data/models/recipe_model.dart';
import '../../../../core/services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

  Future<void> searchRecipes(List<String> ingredients) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _recipeService.fetchRecipesByIngredients(ingredients);
    } catch (e) {
      _error = e.toString();
      _recipes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
