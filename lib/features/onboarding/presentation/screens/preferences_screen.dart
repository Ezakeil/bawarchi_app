import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/preferences_repository.dart';
import '../../../../core/constants/app_colors.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Data Models
  final List<String> dietaryOptions = [
    "No Restriction",
    "Halal",
    "Keto",
    "Vegan",
    "Vegetarian",
    "Paleo",
    "Gluten-Free",
  ];

  final List<String> healthGoals = [
    "Calorie Deficit",
    "Muscle Gain",
    "Maintain",
  ];

  // Selection tracking
  int selectedDietaryIndex = 0; // "No Restriction" is default (FR2.2)
  int? selectedHealthGoalIndex;
  final PreferencesRepository _preferencesRepository = PreferencesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryAmber, AppColors.backgroundCream],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content with padding for FAB
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Header Text
                      Text(
                        "Customize Your Experience",
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.textCharcoal),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tell us your preferences so we can personalize your journey",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Section 1: Dietary Preference (FR2.2)
                      _buildDietarySection(context),
                      const SizedBox(height: 48),

                      // Section 2: Health Goal (FR2.4)
                      _buildHealthGoalSection(context),
                      const SizedBox(height: 120), // Space for FAB
                    ],
                  ),
                ),
              ),

              // Floating Action Button (FR2.5)
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton.extended(
                  onPressed: _handleSaveAndContinue,
                  backgroundColor: AppColors.primaryAmber,
                  foregroundColor: AppColors.textCharcoal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Save & Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section 1: Dietary Preference Widget (FR2.2)
  Widget _buildDietarySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          "Dietary Preference",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Dietary Options Grid/Wrap
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            dietaryOptions.length,
            (index) => _buildDietaryOption(index),
          ),
        ),
      ],
    );
  }

  // Dietary Option Item Widget
  Widget _buildDietaryOption(int index) {
    final isSelected = selectedDietaryIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDietaryIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentViolet.withOpacity(0.15)
              : Colors.white.withOpacity(0.5),
          border: Border.all(
            color: isSelected
                ? AppColors.accentViolet
                : const Color(0xFFD0D0D0),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          dietaryOptions[index],
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected ? AppColors.accentViolet : AppColors.textCharcoal,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Section 2: Health Goal Widget (FR2.4)
  Widget _buildHealthGoalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          "Health Goal",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Health Goals Cards
        Column(
          children:
              List.generate(
                healthGoals.length,
                (index) => _buildHealthGoalCard(index, context),
              ).expand((widget) sync* {
                yield widget;
                yield const SizedBox(height: 12);
              }).toList(),
        ),
      ],
    );
  }

  // Health Goal Card Widget
  Widget _buildHealthGoalCard(int index, BuildContext context) {
    final isSelected = selectedHealthGoalIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHealthGoalIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentViolet.withOpacity(0.15)
              : Colors.white.withOpacity(0.5),
          border: Border.all(
            color: isSelected
                ? AppColors.accentViolet
                : const Color(0xFFD0D0D0),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Goal Text
            Expanded(
              child: Text(
                healthGoals[index],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? AppColors.accentViolet
                      : AppColors.textCharcoal,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),

            // Checkmark Icon
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.accentViolet,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
          ],
        ),
      ),
    );
  }

  // Handle Save & Continue action
  void _handleSaveAndContinue() {
    if (selectedHealthGoalIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a health goal to continue'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final dietary = dietaryOptions[selectedDietaryIndex];
    final goal = healthGoals[selectedHealthGoalIndex!];

    () async {
      try {
        await _preferencesRepository.saveUserPreferences(
          dietaryPreference: dietary,
          healthGoal: goal,
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Preferences saved: $dietary, $goal'),
            duration: const Duration(seconds: 2),
          ),
        );
        context.go('/home');
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save preferences: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }();
  }
}
