import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ReinventorScreen extends StatefulWidget {
  const ReinventorScreen({Key? key}) : super(key: key);

  @override
  State<ReinventorScreen> createState() => _ReinventorScreenState();
}

class _ReinventorScreenState extends State<ReinventorScreen> {
  // Input state
  final TextEditingController _ingredientController = TextEditingController();
  List<String> selectedLeftovers = [];

  // Filter state
  bool quickReuseOnly = false;
  double pantryMatchThreshold = 80.0;

  // Mock results
  late List<ReinventedRecipe> results;

  @override
  void initState() {
    super.initState();
    // Initialize mock reinvented recipes
    results = [
      ReinventedRecipe(
        id: '1',
        title: 'Crispy Chicken Fried Rice',
        tags: ['Quick Reuse', 'Asian Fusion'],
        matchPercentage: 95,
        cookingTime: 12,
      ),
      ReinventedRecipe(
        id: '2',
        title: 'Chicken & Rice Soup Bowl',
        tags: ['Comfort Food', 'Fusion'],
        matchPercentage: 88,
        cookingTime: 18,
      ),
      ReinventedRecipe(
        id: '3',
        title: 'Loaded Rice Cakes',
        tags: ['Quick Reuse', 'Appetizer'],
        matchPercentage: 92,
        cookingTime: 10,
      ),
      ReinventedRecipe(
        id: '4',
        title: 'Creamy Chicken Pasta',
        tags: ['Italian Inspired', 'Fusion'],
        matchPercentage: 85,
        cookingTime: 14,
      ),
    ];
  }

  void _addLeftover() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty && !selectedLeftovers.contains(ingredient)) {
      setState(() {
        selectedLeftovers.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _removeLeftover(String ingredient) {
    setState(() {
      selectedLeftovers.remove(ingredient);
    });
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter results based on quick reuse filter
    final filteredResults = results.where((recipe) {
      if (quickReuseOnly && recipe.cookingTime > 15) return false;
      return recipe.matchPercentage >= pantryMatchThreshold;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (FR12.1)
              _buildHeader(context),
              const SizedBox(height: 24),

              // Input Section (FR12.1, FR12.2)
              _buildInputSection(context),
              const SizedBox(height: 24),

              // Smart Filters Card (FR12.3, FR12.4)
              _buildSmartFiltersCard(context),
              const SizedBox(height: 24),

              // Results Section (FR12.5, FR12.6)
              _buildResultsSection(context, filteredResults),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Header Widget (FR12.1)
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Text(
            'Recipe Reinventor',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Transform your leftovers into creative new dishes',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  // Input Section Widget (FR12.1, FR12.2)
  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Title
          Text(
            'What leftovers do you have?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Selected leftovers chips
          if (selectedLeftovers.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedLeftovers
                  .map((leftover) => _buildRemovableChip(leftover))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Input field with add button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ingredientController,
                  onSubmitted: (_) => _addLeftover(),
                  decoration: InputDecoration(
                    hintText: 'Type leftover ingredient...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Add button
              GestureDetector(
                onTap: _addLeftover,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryAmber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Removable Chip Widget
  Widget _buildRemovableChip(String leftover) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundCream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryAmber),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            leftover,
            style: const TextStyle(
              color: AppColors.primaryAmber,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _removeLeftover(leftover),
            child: const Icon(
              Icons.close,
              color: AppColors.primaryAmber,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // Smart Filters Card Widget (FR12.3, FR12.4)
  Widget _buildSmartFiltersCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Title
          Text(
            'Smart Filters',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Quick Reuse Toggle
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Quick Reuse Only',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textCharcoal),
            ),
            subtitle: Text(
              'Recipes under 15 minutes',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
            value: quickReuseOnly,
            onChanged: (value) {
              setState(() {
                quickReuseOnly = value;
              });
            },
            activeColor: AppColors.primaryAmber,
          ),
          const SizedBox(height: 20),

          // Pantry Match Slider
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pantry Match Threshold',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textCharcoal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${pantryMatchThreshold.toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryAmber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Slider(
                value: pantryMatchThreshold,
                min: 50,
                max: 100,
                divisions: 10,
                activeColor: AppColors.primaryAmber,
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() {
                    pantryMatchThreshold = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Results Section Widget (FR12.5, FR12.6)
  Widget _buildResultsSection(
    BuildContext context,
    List<ReinventedRecipe> recipes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results header with dynamic count
        Text(
          '${recipes.length} Creative Ideas',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Recipe cards list
        if (recipes.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No recipes match your filters',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
              ),
            ),
          )
        else
          Column(
            children: recipes
                .map(
                  (recipe) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildReinventedRecipeCard(context, recipe),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  // Reinvented Recipe Card Widget (FR12.5, FR12.6)
  Widget _buildReinventedRecipeCard(
    BuildContext context,
    ReinventedRecipe recipe,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Opening ${recipe.title}')));
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
              // Image with Match Badge
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

                    // Cooking Time
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${recipe.cookingTime} min',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Special Tags (Quick Reuse, Fusion, etc.)
                    Wrap(
                      spacing: 8,
                      children: recipe.tags
                          .map((tag) => _buildSpecialTagChip(context, tag))
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

  // Special Tag Chip Widget (Amber/Yellow)
  Widget _buildSpecialTagChip(BuildContext context, String tag) {
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

// Reinvented Recipe Model
class ReinventedRecipe {
  final String id;
  final String title;
  final List<String> tags; // e.g., ["Quick Reuse", "Fusion"]
  final int matchPercentage;
  final int cookingTime; // in minutes

  ReinventedRecipe({
    required this.id,
    required this.title,
    required this.tags,
    required this.matchPercentage,
    required this.cookingTime,
  });
}
