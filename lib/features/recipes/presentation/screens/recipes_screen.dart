import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Recipe> recipes;
  late List<Recipe> filteredRecipes;

  @override
  void initState() {
    super.initState();
    // Initialize mock data
    recipes = [
      Recipe(
        id: '1',
        title: 'Chicken Biryani',
        image: null, // Placeholder
        time: 45,
        calories: 520,
        tags: ['Pakistani', 'Halal'],
        matchPercentage: 95,
        isFavorite: false,
      ),
      Recipe(
        id: '2',
        title: 'Creamy Pasta',
        image: null,
        time: 25,
        calories: 580,
        tags: ['Italian'],
        matchPercentage: 88,
        isFavorite: false,
      ),
      Recipe(
        id: '3',
        title: 'Vegetable Stir Fry',
        image: null,
        time: 20,
        calories: 320,
        tags: ['Asian', 'Vegan'],
        matchPercentage: 92,
        isFavorite: false,
      ),
      Recipe(
        id: '4',
        title: 'Paneer Tikka',
        image: null,
        time: 30,
        calories: 380,
        tags: ['Indian', 'Vegetarian'],
        matchPercentage: 85,
        isFavorite: false,
      ),
      Recipe(
        id: '5',
        title: 'Garlic Butter Shrimp',
        image: null,
        time: 15,
        calories: 420,
        tags: ['Seafood', 'Quick'],
        matchPercentage: 78,
        isFavorite: false,
      ),
    ];
    filteredRecipes = recipes;
  }

  void _filterRecipes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRecipes = recipes;
      } else {
        filteredRecipes = recipes
            .where(
              (recipe) =>
                  recipe.title.toLowerCase().contains(query.toLowerCase()) ||
                  recipe.tags.any(
                    (tag) => tag.toLowerCase().contains(query.toLowerCase()),
                  ),
            )
            .toList();
      }
    });
  }

  void _toggleFavorite(String recipeId) {
    setState(() {
      final recipe = recipes.firstWhere((r) => r.id == recipeId);
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      backgroundColor: AppColors.backgroundCream,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search & Filter (FR8.1, FR8.2)
              _buildSearchAndFilter(context),
              const SizedBox(height: 24),

              // Pantry Banner (FR8.3)
              _buildPantryBanner(context),
              const SizedBox(height: 24),

              // Recipe List (FR8.5)
              _buildRecipeList(context),
            ],
          ),
        ),
      ),
    );
  }

  // Search & Filter Widget (FR8.1, FR8.2)
  Widget _buildSearchAndFilter(BuildContext context) {
    return Row(
      children: [
        // Search TextField
        Expanded(
          child: TextField(
            controller: _searchController,
            onChanged: _filterRecipes,
            decoration: InputDecoration(
              hintText: 'Search recipes...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter Button
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_list),
            color: AppColors.textCharcoal,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter feature coming soon')),
              );
            },
          ),
        ),
      ],
    );
  }

  // Pantry Banner Widget (FR8.3)
  Widget _buildPantryBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFB74D), // Orange
            const Color(0xFFFF9800), // Darker Orange
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9800).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Based on Your Pantry!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can make 5 recipes with what you have.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // Recipe List Widget (FR8.5)
  Widget _buildRecipeList(BuildContext context) {
    return Column(
      children: List.generate(
        filteredRecipes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildRecipeCard(context, filteredRecipes[index]),
        ),
      ),
    );
  }

  // Recipe Card Widget (FR8.5)
  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        // Encode title to make the URL safe (spaces/special chars)
        final encoded = Uri.encodeComponent(recipe.title);
        context.push(
          '/recipes/detail/$encoded?match=${recipe.matchPercentage}',
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Match Badge and Favorite Icon
              Stack(
                children: [
                  // Placeholder Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.primaryAmber.withOpacity(0.15),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      size: 64,
                      color: AppColors.primaryAmber,
                    ),
                  ),

                  // Match Percentage Badge (Top-Left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.highlightMint,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        '${recipe.matchPercentage}% Match',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textCharcoal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Favorite Icon (Top-Right)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(recipe.id),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          recipe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: recipe.isFavorite
                              ? Colors.red
                              : AppColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Title
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textCharcoal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Time and Calories Row
                    Row(
                      children: [
                        // Time
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${recipe.time} min',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                        const SizedBox(width: 20),

                        // Calories
                        Icon(
                          Icons.local_fire_department,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${recipe.calories} cal',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Tags
                    Wrap(
                      spacing: 8,
                      children: recipe.tags
                          .map((tag) => _buildTagChip(context, tag))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tag Chip Widget
  Widget _buildTagChip(BuildContext context, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryAmber.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.primaryAmber,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Recipe Model
class Recipe {
  final String id;
  final String title;
  final dynamic image;
  final int time; // in minutes
  final int calories;
  final List<String> tags;
  final int matchPercentage;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.time,
    required this.calories,
    required this.tags,
    required this.matchPercentage,
    required this.isFavorite,
  });
}
