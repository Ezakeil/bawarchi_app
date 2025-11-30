import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HealthySwapsScreen extends StatefulWidget {
  const HealthySwapsScreen({Key? key}) : super(key: key);

  @override
  State<HealthySwapsScreen> createState() => _HealthySwapsScreenState();
}

class _HealthySwapsScreenState extends State<HealthySwapsScreen> {
  late List<HealthySwap> swaps;

  @override
  void initState() {
    super.initState();
    // Initialize mock healthy swaps
    swaps = [
      HealthySwap(
        id: '1',
        originalTitle: 'White Rice',
        originalCalories: 205,
        originalCarbs: 45,
        alternativeTitle: 'Quinoa',
        alternativeCalories: 120,
        alternativeCarbs: 21,
        benefit: '50% fewer carbs',
        tip: 'Steam for better nutrients',
        isInPantry: true,
      ),
      HealthySwap(
        id: '2',
        originalTitle: 'Butter',
        originalCalories: 102,
        originalCarbs: 0,
        alternativeTitle: 'Olive Oil',
        alternativeCalories: 120,
        alternativeCarbs: 0,
        benefit: 'More heart-healthy fats',
        tip: 'Use for low-heat cooking',
        isInPantry: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Healthy Swaps'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Banner (FR14.2)
              _buildInfoBanner(context),
              const SizedBox(height: 24),

              // Swap Cards
              _buildSwapCardsSection(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Info Banner Widget (FR14.2)
  Widget _buildInfoBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryAmber.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAmber.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: AppColors.primaryAmber, size: 24),
              const SizedBox(width: 12),
              Text(
                'AI-Powered Suggestions',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'These swaps are based on your dietary goals and nutritional preferences. Make healthier choices without sacrificing taste!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textCharcoal,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Swap Cards Section
  Widget _buildSwapCardsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested Swaps',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: swaps
              .map(
                (swap) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SwapCard(swap: swap),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// Swap Card Widget (FR14.4, FR14.6, FR14.7, FR14.8)
class SwapCard extends StatelessWidget {
  final HealthySwap swap;

  const SwapCard({Key? key, required this.swap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
          children: [
            // Main Swap Row (FR14.4)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Original Item (Left)
                  Expanded(
                    child: _buildItemColumn(
                      context,
                      title: swap.originalTitle,
                      calories: swap.originalCalories,
                      carbs: swap.originalCarbs,
                      backgroundColor: const Color(0xFFFFF9E6), // Light Yellow
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Arrow Icon with Benefit Tag (FR14.6)
                  Column(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryAmber,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
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
                          swap.benefit,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.primaryAmber,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),

                  // Alternative Item (Right) with Pantry Tag (FR14.7)
                  Expanded(
                    child: Stack(
                      children: [
                        _buildItemColumn(
                          context,
                          title: swap.alternativeTitle,
                          calories: swap.alternativeCalories,
                          carbs: swap.alternativeCarbs,
                          backgroundColor: AppColors.highlightMint.withOpacity(
                            0.2,
                          ),
                        ),
                        // Pantry Badge (FR14.7)
                        if (swap.isInPantry)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE082), // Yellow
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'In Pantry',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: AppColors.textCharcoal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tip Footer (FR14.8)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.accentViolet.withOpacity(0.15),
                border: Border(
                  top: BorderSide(
                    color: AppColors.accentViolet.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, size: 16, color: AppColors.accentViolet),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      swap.tip,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.accentViolet,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Item Column Widget
  Widget _buildItemColumn(
    BuildContext context, {
    required String title,
    required int calories,
    required int carbs,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'Cal: $calories',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Carbs: ${carbs}g',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Healthy Swap Model
class HealthySwap {
  final String id;
  final String originalTitle;
  final int originalCalories;
  final int originalCarbs;
  final String alternativeTitle;
  final int alternativeCalories;
  final int alternativeCarbs;
  final String benefit; // e.g., "50% fewer carbs"
  final String tip; // e.g., "Steam for better nutrients"
  final bool isInPantry;

  HealthySwap({
    required this.id,
    required this.originalTitle,
    required this.originalCalories,
    required this.originalCarbs,
    required this.alternativeTitle,
    required this.alternativeCalories,
    required this.alternativeCarbs,
    required this.benefit,
    required this.tip,
    required this.isInPantry,
  });
}
