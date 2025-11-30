import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;

  const MainWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  // Navigation items
  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'label': 'Home', 'route': '/home'},
    {'icon': Icons.menu_book, 'label': 'Recipes', 'route': '/recipes'},
    {'icon': Icons.camera_alt, 'label': 'Scan', 'route': '/scan'},
    {'icon': Icons.kitchen, 'label': 'Pantry', 'route': '/pantry'},
    {'icon': Icons.person, 'label': 'Profile', 'route': '/profile'},
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the corresponding route
    context.go(_navItems[index]['route']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryAmber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          // Home
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
          // Recipes
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          // Scan - Elevated/Larger
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryAmber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.camera_alt, size: 28),
            ),
            label: 'Scan',
          ),
          // Pantry
          BottomNavigationBarItem(
            icon: const Icon(Icons.kitchen),
            label: 'Pantry',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
