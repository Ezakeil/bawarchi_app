import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/voice_helper.dart';
import '../../../auth/presentation/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Helper function to get greeting based on time
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.accentViolet),
            onPressed: () => showVoiceAssistant(context),
            tooltip: 'Voice Assistant',
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundCream,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (FR3.1)
              _buildHeader(context),
              const SizedBox(height: 32),

              // Pantry Overview Card (FR3.2)
              _buildPantryOverviewCard(context),
              const SizedBox(height: 32),

              // Quick Actions (FR3.4)
              _buildQuickActions(context),
              const SizedBox(height: 32),

              // Recommendations Section (FR3.5)
              _buildRecommendationsSection(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Header Widget (FR3.1)
  Widget _buildHeader(BuildContext context) {
    final greeting = _getGreeting();
    final userName = Provider.of<UserProvider>(context).userName ?? 'Chef';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good $greeting, $userName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textCharcoal,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'What shall we cook today?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  // Pantry Overview Card (FR3.2)
  Widget _buildPantryOverviewCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Pantry',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn(context, '24', 'Items'),
              _buildStatColumn(context, '8', 'Categories'),
              _buildStatColumn(context, '18', 'Recipes'),
            ],
          ),
        ],
      ),
    );
  }

  // Stat Column Widget
  Widget _buildStatColumn(BuildContext context, String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.highlightMint,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  // Quick Actions Widget (FR3.4)
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuickActionButton(context, Icons.camera_alt, 'Scan'),
            _buildQuickActionButton(context, Icons.explore, 'Explore'),
            _buildQuickActionButton(context, Icons.auto_awesome, 'Reinvent'),
          ],
        ),
      ],
    );
  }

  // Quick Action Button Widget
  Widget _buildQuickActionButton(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'Scan':
            context.go('/scan');
            break;
          case 'Explore':
            context.go('/recipes');
            break;
          case 'Reinvent':
            context.go('/reinventor');
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label feature coming soon')),
            );
        }
      },
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: AppColors.primaryAmber),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Recommendations Section (FR3.5)
  Widget _buildRecommendationsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended for You',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('See All recipes coming soon')),
                );
              },
              child: Text(
                'See All',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              final recipes = [
                RecipeCard(
                  title: 'Chicken Biryani',
                  duration: '45 min',
                  calories: '520 cal',
                ),
                RecipeCard(
                  title: 'Paneer Tikka',
                  duration: '30 min',
                  calories: '380 cal',
                ),
                RecipeCard(
                  title: 'Vegetable Curry',
                  duration: '25 min',
                  calories: '250 cal',
                ),
                RecipeCard(
                  title: 'Butter Chicken',
                  duration: '40 min',
                  calories: '480 cal',
                ),
                RecipeCard(
                  title: 'Dal Makhani',
                  duration: '35 min',
                  calories: '320 cal',
                ),
              ];
              return _buildRecipeCard(context, recipes[index]);
            },
          ),
        ),
      ],
    );
  }

  // Recipe Card Widget (FR3.6)
  Widget _buildRecipeCard(BuildContext context, RecipeCard recipe) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Opening ${recipe.title}')));
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryAmber.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Icon(
                Icons.restaurant,
                size: 48,
                color: AppColors.primaryAmber,
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textCharcoal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Duration Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAmber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          recipe.duration,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.primaryAmber,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      // Calories
                      Text(
                        recipe.calories,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Recipe Card Model
class RecipeCard {
  final String title;
  final String duration;
  final String calories;

  RecipeCard({
    required this.title,
    required this.duration,
    required this.calories,
  });
}
