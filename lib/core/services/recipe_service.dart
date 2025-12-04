import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/recipes/data/models/recipe_model.dart';

class RecipeService {
  final String _baseUrl = 'http://192.168.0.199:8000/api/v1/recipes/generate';

  Future<List<Recipe>> fetchRecipesByIngredients(List<String> ingredients) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'pantry_ingredients': ingredients,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Recipe.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }
}
