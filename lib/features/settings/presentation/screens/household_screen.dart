import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HouseholdScreen extends StatefulWidget {
  const HouseholdScreen({Key? key}) : super(key: key);

  @override
  State<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
  // Mock household members
  final List<HouseholdMember> members = [
    HouseholdMember(
      id: '1',
      name: 'Ali Khan',
      avatar: 'A',
      avatarColor: AppColors.accentViolet,
      dietaryTags: ['Vegetarian'],
      allergies: ['Nuts', 'Dairy'],
      goal: 'Muscle Gain',
    ),
    HouseholdMember(
      id: '2',
      name: 'Sara Khan',
      avatar: 'S',
      avatarColor: AppColors.highlightMint,
      dietaryTags: ['Halal'],
      allergies: ['Shellfish'],
      goal: null,
    ),
  ];

  final int maxMembers = 2;

  @override
  Widget build(BuildContext context) {
    bool isMaxMembers = members.length >= maxMembers;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Household Members'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      body: Column(
        children: [
          // Banner (FR18.7)
          _buildBanner(context),

          // Member Cards (FR18.3)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: members.length,
              itemBuilder: (context, index) {
                return _buildMemberCard(context, members[index]);
              },
            ),
          ),

          // Add Button (FR18.2)
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isMaxMembers
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Add Member functionality coming soon',
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isMaxMembers
                      ? Colors.grey[300]
                      : AppColors.primaryAmber,
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isMaxMembers ? 'Max Members Reached' : 'Add Member',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isMaxMembers ? Colors.grey[600] : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Banner Widget (FR18.7)
  Widget _buildBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE082).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFFE082).withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: const Color(0xFFFFE082), size: 20),
              const SizedBox(width: 8),
              Text(
                'Household Settings',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textCharcoal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Max 2 members: Each can have individual preferences and dietary restrictions. Recipes will cross-check all restrictions automatically',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Member Card Widget (FR18.3)
  Widget _buildMemberCard(BuildContext context, HouseholdMember member) {
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
          // Header with Avatar and Name
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar Circle
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: member.avatarColor.withOpacity(0.2),
                    border: Border.all(
                      color: member.avatarColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      member.avatar,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: member.avatarColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textCharcoal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Member',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Edit/Delete Icon
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  color: AppColors.textMuted,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Edit ${member.name} coming soon'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Dietary Tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dietary Preferences',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: member.dietaryTags
                      .map(
                        (tag) => _buildChip(
                          label: tag,
                          backgroundColor: const Color(0xFFFFE082),
                          textColor: AppColors.textCharcoal,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Allergies
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Allergies',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: member.allergies
                      .map(
                        (allergy) => _buildChip(
                          label: allergy,
                          backgroundColor: const Color(
                            0xFFFF69B4,
                          ).withOpacity(0.15),
                          textColor: const Color(0xFFFF1493),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // Goal (if present)
          if (member.goal != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fitness Goal',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildChip(
                    label: member.goal!,
                    backgroundColor: AppColors.accentViolet.withOpacity(0.15),
                    textColor: AppColors.accentViolet,
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Footer Text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryAmber.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              'All recipes automatically checked for ${member.name}\'s restrictions and preferences',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.primaryAmber,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chip Widget
  Widget _buildChip({
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textCharcoal,
        ),
      ),
    );
  }
}

// Household Member Model
class HouseholdMember {
  final String id;
  final String name;
  final String avatar;
  final Color avatarColor;
  final List<String> dietaryTags;
  final List<String> allergies;
  final String? goal;

  HouseholdMember({
    required this.id,
    required this.name,
    required this.avatar,
    required this.avatarColor,
    required this.dietaryTags,
    required this.allergies,
    this.goal,
  });
}
