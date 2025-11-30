import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      body: Column(
        children: [
          // Settings List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Household Members
                _buildSettingsListTile(
                  context,
                  icon: Icons.people,
                  title: 'Household Members',
                  onTap: () => context.go('/settings/household'),
                  trailing: _buildCircleBadge('2', AppColors.primaryAmber),
                ),

                // Saved Recipes
                _buildSettingsListTile(
                  context,
                  icon: Icons.bookmark,
                  title: 'Saved Recipes',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Saved Recipes coming soon'),
                      ),
                    );
                  },
                  trailing: _buildCircleBadge('24', const Color(0xFFFFE082)),
                ),

                // Cooking History
                _buildSettingsListTile(
                  context,
                  icon: Icons.history,
                  title: 'Cooking History',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cooking History coming soon'),
                      ),
                    );
                  },
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ),

                // Allergy Shield
                _buildSettingsListTile(
                  context,
                  icon: Icons.shield,
                  title: 'Allergy Shield',
                  onTap: () => context.go('/settings/allergy-shield'),
                  trailing: _buildStatusBadge(
                    'Active',
                    const Color(0xFFFF9800),
                  ),
                ),

                // Macro Goals
                _buildSettingsListTile(
                  context,
                  icon: Icons.restaurant,
                  title: 'Macro Goals',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Macro Goals coming soon')),
                    );
                  },
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ),

                // App Settings
                _buildSettingsListTile(
                  context,
                  icon: Icons.settings,
                  title: 'App Settings',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('App Settings coming soon')),
                    );
                  },
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Footer Banner (FR17.8)
          _buildFooterBanner(context),
        ],
      ),
    );
  }

  // Settings ListTile Widget
  Widget _buildSettingsListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: AppColors.primaryAmber, size: 24),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  // Circle Badge Widget (for Household Members, Saved Recipes)
  Widget _buildCircleBadge(String text, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Status Badge Widget (for Allergy Shield)
  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textCharcoal,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Footer Banner Widget (FR17.8)
  Widget _buildFooterBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF9E9E9E).withOpacity(0.15),
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: AppColors.textMuted, size: 20),
              const SizedBox(width: 8),
              Text(
                'Allergy Integration',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textCharcoal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your allergy settings (2 active) are automatically synced with all recipe outputs for your safety',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
