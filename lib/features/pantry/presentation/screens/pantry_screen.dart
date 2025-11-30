import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  // Mock data structure
  final List<PantryCategory> categories = [
    PantryCategory(
      name: 'Vegetables',
      itemCount: 8,
      items: [
        PantryItem(name: 'Spinach', quantity: '200g'),
        PantryItem(name: 'Tomatoes', quantity: '6 pcs'),
        PantryItem(name: 'Onions', quantity: '4 pcs'),
      ],
    ),
    PantryCategory(
      name: 'Spices',
      itemCount: 12,
      items: [
        PantryItem(name: 'Salt', quantity: '500g'),
        PantryItem(name: 'Pepper', quantity: '100g'),
        PantryItem(name: 'Turmeric', quantity: '50g'),
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantry'),
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
              // Search & Filter Row (FR6.1, FR6.2)
              _buildSearchAndFilter(context),
              const SizedBox(height: 24),

              // Summary Cards (FR6.4)
              _buildSummaryCards(context),
              const SizedBox(height: 24),

              // Ready to Cook Banner (FR6.5)
              _buildReadyToCookBanner(context),
              const SizedBox(height: 24),

              // Category List (FR6.6)
              _buildCategoryList(context),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
      // Floating Action Button (FR6.3)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Items feature coming soon')),
          );
        },
        backgroundColor: AppColors.primaryAmber,
        foregroundColor: AppColors.textCharcoal,
        icon: const Icon(Icons.add),
        label: const Text('Add Items'),
      ),
    );
  }

  // Search & Filter Widget (FR6.1, FR6.2)
  Widget _buildSearchAndFilter(BuildContext context) {
    return Row(
      children: [
        // Search TextField
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search ingredients...',
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

  // Summary Cards Widget (FR6.4)
  Widget _buildSummaryCards(BuildContext context) {
    return Row(
      children: [
        // Total Items Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '21',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textCharcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Items',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Recipes Available Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.highlightMint,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '18',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textCharcoal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Recipes Available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textCharcoal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Ready to Cook Banner Widget (FR6.5)
  Widget _buildReadyToCookBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentViolet,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ready to Cook!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can make 18 recipes with your current pantry items.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // Category List Widget (FR6.6)
  Widget _buildCategoryList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryExpansion(context, categories[index]);
          },
        ),
      ],
    );
  }

  // Category Expansion Tile Widget
  Widget _buildCategoryExpansion(
    BuildContext context,
    PantryCategory category,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryAmber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${category.itemCount} items',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: List.generate(
                category.items.length,
                (itemIndex) => _buildIngredientRow(
                  context,
                  category.items[itemIndex],
                  itemIndex == category.items.length - 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Ingredient Row Widget
  Widget _buildIngredientRow(
    BuildContext context,
    PantryItem item,
    bool isLast,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textCharcoal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.quantity,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: AppColors.textMuted,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('More options for ${item.name}')),
                );
              },
            ),
          ],
        ),
        if (!isLast) Divider(color: const Color(0xFFE0E0E0), height: 16),
      ],
    );
  }
}

// Model classes
class PantryCategory {
  final String name;
  final int itemCount;
  final List<PantryItem> items;

  PantryCategory({
    required this.name,
    required this.itemCount,
    required this.items,
  });
}

class PantryItem {
  final String name;
  final String quantity;

  PantryItem({required this.name, required this.quantity});
}
