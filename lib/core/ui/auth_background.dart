import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Stack(
        children: [
          // Blob 1: Top-right corner
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryAmber.withOpacity(0.3),
              ),
            ),
          ),
          // Blob 2: Bottom-left corner
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentViolet.withOpacity(0.2),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Center(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
