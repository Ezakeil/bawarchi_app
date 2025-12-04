import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../../../../core/constants/app_colors.dart';

class RecipeDiscoveryScreen extends StatefulWidget {
  const RecipeDiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<RecipeDiscoveryScreen> createState() => _RecipeDiscoveryScreenState();
}

class _RecipeDiscoveryScreenState extends State<RecipeDiscoveryScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger initial search with default ingredients or pantry items
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false)
          .searchRecipes(['chicken', 'rice']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Recipes'),
        backgroundColor: AppColors.backgroundCream,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundCream,
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.recipes.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.recipes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RecipeCard(
                  recipe: recipe,
                  onToggleFavorite: () {
                    // TODO: Implement favorite toggle
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
