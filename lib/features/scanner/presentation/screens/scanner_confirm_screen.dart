import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class ScannerConfirmScreen extends StatelessWidget {
  const ScannerConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Items'),
        elevation: 0,
        backgroundColor: AppColors.backgroundCream,
      ),
      backgroundColor: AppColors.backgroundCream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.highlightMint.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.highlightMint,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Items Detected!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textCharcoal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We found Tomato and Onion. Do you want to add them to your pantry?',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Items added to pantry!')),
                    );
                    context.go('/pantry');
                  },
                  child: const Text('Add to Pantry'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Retake'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
