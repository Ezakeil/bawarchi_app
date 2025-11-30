import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeTitle;
  final int matchPercentage;

  const RecipeDetailScreen({
    Key? key,
    required this.recipeTitle,
    required this.matchPercentage,
  }) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image with tags overlay (FR9.2)
                _buildHeroImage(context),

                // Stats Bar (FR9.3)
                _buildStatsBar(context),

                // Pantry Match Summary (FR9.7)
                _buildPantryMatchSummary(context),

                // Ingredient List (FR9.8)
                _buildIngredientList(context),

                // Extra spacing for FAB
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Top app bar with back and favorite buttons
          _buildTopBar(context),
        ],
      ),
      floatingActionButton: _buildStartCookingFAB(context),
    );
  }

  // Top App Bar with Back and Favorite (FR9.1)
  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textCharcoal,
                    size: 24,
                  ),
                ),
              ),

              // Favorite Button
              GestureDetector(
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : AppColors.textMuted,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hero Image with Tags Overlay (FR9.2)
  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        // Image Container
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.primaryAmber.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Icon(
            Icons.restaurant,
            size: 100,
            color: AppColors.primaryAmber,
          ),
        ),

        // Tags Overlay (Bottom Left)
        Positioned(
          bottom: 16,
          left: 16,
          child: Row(
            children: ['Pakistani', 'Halal']
                .map(
                  (tag) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        tag,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primaryAmber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  // Stats Bar: Time, Servings, Calories (FR9.3)
  Widget _buildStatsBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            icon: Icons.schedule,
            value: '45',
            unit: 'min',
          ),
          _buildStatItem(
            context,
            icon: Icons.people,
            value: '4',
            unit: 'servings',
          ),
          _buildStatItem(
            context,
            icon: Icons.local_fire_department,
            value: '130',
            unit: 'cal/serving',
          ),
        ],
      ),
    );
  }

  // Individual Stat Item
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryAmber, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          unit,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  // Pantry Match Summary (FR9.7)
  Widget _buildPantryMatchSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.highlightMint,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.highlightMint.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pantry Match',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textCharcoal.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have 4/6 ingredients',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textCharcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(Icons.check_circle, color: Colors.green[700], size: 40),
          ],
        ),
      ),
    );
  }

  // Ingredient List (FR9.8)
  Widget _buildIngredientList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // In Pantry Section
          _buildIngredientSection(
            context,
            title: 'In Pantry',
            items: [('Basmati Rice', '2 cups'), ('Chicken', '500g')],
            dotColor: AppColors.highlightMint,
          ),
          const SizedBox(height: 20),

          // Missing Section
          _buildIngredientSection(
            context,
            title: 'Missing',
            items: [('Onions', '2 large')],
            dotColor: AppColors.textMuted,
          ),
        ],
      ),
    );
  }

  // Ingredient Section (In Pantry or Missing)
  Widget _buildIngredientSection(
    BuildContext context, {
    required String title,
    required List<(String, String)> items,
    required Color dotColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Ingredient Items
        Column(
          children: items.asMap().entries.map((entry) {
            int index = entry.key;
            var (name, quantity) = entry.value;
            bool isLast = index == items.length - 1;

            return Column(
              children: [
                Row(
                  children: [
                    // Dot Bullet
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Ingredient Details
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textCharcoal),
                          ),
                          Text(
                            quantity,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (!isLast) ...[
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey[300], height: 1),
                  const SizedBox(height: 12),
                ],
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // Start Cooking FAB (FR9.9)
  Widget _buildStartCookingFAB(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Navigate to Cooking Mode');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Navigate to Cooking Mode'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        margin: const EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryAmber,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryAmber.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_arrow, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              'Start Cooking',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
