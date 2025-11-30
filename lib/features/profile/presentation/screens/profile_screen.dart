import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Cooking Preferences State
  String selectedSpiceLevel = 'Medium';
  String selectedExpertise = 'Intermediate';

  // Flavor Profile State
  Set<String> selectedFlavors = {'Savory', 'Tangy'};

  // Mock User Data
  final String userName = 'Aisha Khan';
  final int recipesCooked = 48;
  final int streakDays = 12;
  final int savedItems = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Amber Gradient (FR16.2)
            _buildHeader(context),

            // Cooking Preferences Section (FR16.3, FR16.4)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPreferencesSection(context),
                  const SizedBox(height: 32),

                  // Flavor Profile Section (FR16.5)
                  _buildFlavorProfileSection(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Stats Bar (FR16.6)
            _buildStatsBar(context),
          ],
        ),
      ),
    );
  }

  // Header Widget with Amber Gradient (FR16.2)
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryAmber,
            AppColors.primaryAmber.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primaryAmber,
                  ),
                ),

                // Settings Icon (FR16.2)
                GestureDetector(
                  onTap: () {
                    context.go('/settings');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.settings,
                      color: AppColors.primaryAmber,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // User Name
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Home Chef',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cooking Preferences Section (FR16.3, FR16.4)
  Widget _buildPreferencesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Spice Level
        Text(
          'Spice Level',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['Mild', 'Medium', 'Spicy', 'Extra Spicy']
              .map(
                (level) => _buildPreferenceChip(
                  context,
                  label: level,
                  isSelected: selectedSpiceLevel == level,
                  onTap: () {
                    setState(() {
                      selectedSpiceLevel = level;
                    });
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),

        // Cooking Expertise
        Text(
          'Cooking Expertise',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['Beginner', 'Intermediate', 'Expert']
              .map(
                (level) => _buildPreferenceChip(
                  context,
                  label: level,
                  isSelected: selectedExpertise == level,
                  onTap: () {
                    setState(() {
                      selectedExpertise = level;
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Preference Chip Widget (FR16.3, FR16.4)
  Widget _buildPreferenceChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentViolet : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.accentViolet : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accentViolet.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Flavor Profile Section (FR16.5)
  Widget _buildFlavorProfileSection(BuildContext context) {
    final flavorOptions = [
      'Sweet',
      'Savory',
      'Tangy',
      'Spicy',
      'Umami',
      'Bitter',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Flavors',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: flavorOptions
              .map(
                (flavor) => _buildFlavorChip(
                  context,
                  label: flavor,
                  isSelected: selectedFlavors.contains(flavor),
                  onTap: () {
                    setState(() {
                      if (selectedFlavors.contains(flavor)) {
                        selectedFlavors.remove(flavor);
                      } else {
                        selectedFlavors.add(flavor);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Flavor Chip Widget (FR16.5)
  Widget _buildFlavorChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryAmber.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryAmber : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Icon(Icons.check, size: 14, color: AppColors.primaryAmber),
            ],
          ],
        ),
      ),
    );
  }

  // Stats Bar Widget (FR16.6)
  Widget _buildStatsBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard(
            context,
            number: '$recipesCooked',
            label: 'Recipes Cooked',
            color: const Color(0xFFFFE082), // Yellow
          ),
          _buildStatCard(
            context,
            number: '$streakDays',
            label: 'Days Streak',
            color: AppColors.accentViolet,
          ),
          _buildStatCard(
            context,
            number: '$savedItems',
            label: 'Saved Items',
            color: AppColors.highlightMint,
          ),
        ],
      ),
    );
  }

  // Stat Card Widget (FR16.6)
  Widget _buildStatCard(
    BuildContext context, {
    required String number,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
