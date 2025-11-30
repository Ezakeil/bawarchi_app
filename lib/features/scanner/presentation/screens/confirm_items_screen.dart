import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class ConfirmItemsScreen extends StatefulWidget {
  const ConfirmItemsScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmItemsScreen> createState() => _ConfirmItemsScreenState();
}

class _ConfirmItemsScreenState extends State<ConfirmItemsScreen> {
  late List<DetectedItem> items;

  @override
  void initState() {
    super.initState();
    // Initialize with mock data
    items = [
      DetectedItem(
        id: '1',
        name: 'Tomatoes',
        quantity: '6 pcs',
        category: 'Vegetables',
        isSelected: true,
      ),
      DetectedItem(
        id: '2',
        name: 'Onions',
        quantity: '4 pcs',
        category: 'Vegetables',
        isSelected: true,
      ),
      DetectedItem(
        id: '3',
        name: 'Garlic',
        quantity: '1 bulb',
        category: 'Vegetables',
        isSelected: true,
      ),
    ];
  }

  void _addItemManually() {
    setState(() {
      items.add(
        DetectedItem(
          id: DateTime.now().toString(),
          name: '',
          quantity: '',
          category: 'Vegetables',
          isSelected: true,
        ),
      );
    });
  }

  void _deleteItem(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  void _saveAllItems() {
    // Filter only selected items
    final selectedItems = items.where((item) => item.isSelected).toList();

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item')),
      );
      return;
    }

    // TODO: Save items to backend/local storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved ${selectedItems.length} items to pantry')),
    );

    // Navigate to home/dashboard
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = items.where((item) => item.isSelected).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Items'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      backgroundColor: AppColors.backgroundCream,
      body: Column(
        children: [
          // Banner (FR5.1)
          _buildBanner(context),

          // List of Items (FR5.3, FR5.4)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: items.length + 1, // +1 for "Add Item Manually" button
              itemBuilder: (context, index) {
                if (index == items.length) {
                  // Add Item Manually Button (FR5.5)
                  return _buildAddItemManuallyButton(context);
                }
                return _buildItemCard(context, items[index]);
              },
            ),
          ),
        ],
      ),
      // Bottom Action Bar (FR5.6)
      bottomNavigationBar: _buildBottomActionBar(context, selectedCount),
    );
  }

  // Banner Widget (FR5.1)
  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6), // Light yellow
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We detected ${items.length} items.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textCharcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review, edit, or add more below.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  // Item Card Widget (FR5.3, FR5.4)
  Widget _buildItemCard(BuildContext context, DetectedItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Checkbox (Leading)
            Checkbox(
              value: item.isSelected,
              onChanged: (value) {
                setState(() {
                  item.isSelected = value ?? false;
                });
              },
              activeColor: AppColors.highlightMint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Name TextField
                  TextFormField(
                    initialValue: item.name,
                    onChanged: (value) {
                      item.name = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Item name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),

                  // Quantity and Category Row
                  Row(
                    children: [
                      // Quantity Field
                      Expanded(
                        child: TextFormField(
                          initialValue: item.quantity,
                          onChanged: (value) {
                            item.quantity = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Qty',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Category Dropdown
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: item.category,
                          items: const [
                            DropdownMenuItem(
                              value: 'Vegetables',
                              child: Text('Vegetables'),
                            ),
                            DropdownMenuItem(
                              value: 'Spices',
                              child: Text('Spices'),
                            ),
                            DropdownMenuItem(
                              value: 'Fruits',
                              child: Text('Fruits'),
                            ),
                            DropdownMenuItem(
                              value: 'Dairy',
                              child: Text('Dairy'),
                            ),
                            DropdownMenuItem(
                              value: 'Grains',
                              child: Text('Grains'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              item.category = value ?? 'Vegetables';
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Delete Button (Trailing) (FR5.4)
            GestureDetector(
              onTap: () => _deleteItem(item.id),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add Item Manually Button (FR5.5)
  Widget _buildAddItemManuallyButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.textMuted,
          width: 2,
          strokeAlign: BorderSide.strokeAlignCenter,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _addItemManually,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primaryAmber, size: 20),
              const SizedBox(width: 8),
              Text(
                'Add Item Manually',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primaryAmber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Action Bar (FR5.6)
  Widget _buildBottomActionBar(BuildContext context, int selectedCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveAllItems,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAmber,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Save All Items ($selectedCount)',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Model Class for Detected Item
class DetectedItem {
  final String id;
  String name;
  String quantity;
  String category;
  bool isSelected;

  DetectedItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.isSelected,
  });
}
