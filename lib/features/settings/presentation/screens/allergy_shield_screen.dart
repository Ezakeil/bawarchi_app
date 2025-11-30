import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AllergyShieldScreen extends StatefulWidget {
  const AllergyShieldScreen({Key? key}) : super(key: key);

  @override
  State<AllergyShieldScreen> createState() => _AllergyShieldScreenState();
}

class _AllergyShieldScreenState extends State<AllergyShieldScreen> {
  // Track expanded state and severity selection for each allergen
  Map<String, String> allergenSeverity = {
    'Peanuts': 'Severe',
    'Dairy': 'Moderate',
  };

  final List<Allergen> allergens = [
    Allergen(
      id: '1',
      name: 'Peanuts',
      severity: 'Severe',
      safeAlternatives: ['Almonds', 'Cashew'],
    ),
    Allergen(
      id: '2',
      name: 'Dairy',
      severity: 'Moderate',
      safeAlternatives: ['Oat Milk', 'Soy Milk'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Allergy Shield'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Protection Header (FR20.2)
            _buildProtectionHeader(context),

            const SizedBox(height: 32),

            // My Allergens List (FR20.4)
            _buildAllergensSection(context),
          ],
        ),
      ),
    );
  }

  // Protection Header Widget (FR20.2)
  Widget _buildProtectionHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Icon
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentViolet.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.shield,
                  color: AppColors.accentViolet,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Smart Allergy Protection',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textCharcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bullet Points
          _buildBulletPoint(
            context,
            'All recipes are scanned against your allergens before recommendations',
          ),
          const SizedBox(height: 12),
          _buildBulletPoint(
            context,
            'Cross-contamination risks flagged with clear warnings',
          ),
          const SizedBox(height: 12),
          _buildBulletPoint(
            context,
            'Safe substitutes suggested to expand your recipe options',
          ),
        ],
      ),
    );
  }

  // Bullet Point Widget
  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 12),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primaryAmber,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // My Allergens Section (FR20.4)
  Widget _buildAllergensSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Add Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Allergens',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add new allergen coming soon')),
                );
              },
              child: Text(
                '+ Add New',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Allergen Items
        ...allergens.map((allergen) {
          return _buildAllergenCard(context, allergen);
        }).toList(),
      ],
    );
  }

  // Allergen Card Widget
  Widget _buildAllergenCard(BuildContext context, Allergen allergen) {
    Color severityColor = _getSeverityColor(allergen.severity);
    String severityLabel = allergen.severity;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title and Badge
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  allergen.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textCharcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Severity Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: severityColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '$severityLabel Allergy',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: severityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Safe Alternatives Subtext (Green)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Safe alternatives: ${allergen.safeAlternatives.join(', ')}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.highlightMint,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Severity Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Severity Level',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['Mild', 'Moderate', 'Severe'].map((severity) {
                    bool isSelected =
                        allergenSeverity[allergen.name] == severity;
                    Color btnColor = _getSeverityColor(severity);

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              allergenSeverity[allergen.name] = severity;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? btnColor.withOpacity(0.15)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? btnColor.withOpacity(0.4)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                severity,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: isSelected
                                          ? btnColor
                                          : AppColors.textMuted,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Delete Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Delete ${allergen.name} coming soon'),
                  ),
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                'Remove Allergen',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Helper: Get severity color
  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Mild':
        return const Color(0xFFFFC107); // Amber
      case 'Moderate':
        return const Color(0xFFFF9800); // Orange
      case 'Severe':
        return const Color(0xFFE74C3C); // Red
      default:
        return AppColors.textMuted;
    }
  }
}

// Allergen Model
class Allergen {
  final String id;
  final String name;
  final String severity;
  final List<String> safeAlternatives;

  Allergen({
    required this.id,
    required this.name,
    required this.severity,
    required this.safeAlternatives,
  });
}
