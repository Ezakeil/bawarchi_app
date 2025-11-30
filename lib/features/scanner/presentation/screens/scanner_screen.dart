import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Setup pulsing animation for "AI Scanning..." dot
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleCapture() {
    // Navigate to items review/confirmation route
    context.go('/scanner/review');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background: Black Container (simulating camera preview) (FR4.4)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: Text(
                'Camera Preview',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
          ),

          // Top Bar (FR4.2)
          _buildTopBar(context),

          // Center Scanning Text & Pulsing Dot
          _buildScanningIndicator(),

          // Scanning Overlay with Focus Area & Detection Chips (FR4.5)
          _buildScanningOverlay(context, screenSize),

          // Bottom Control Panel (FR4.6)
          _buildBottomControlPanel(context, screenSize),
        ],
      ),
    );
  }

  // Top Bar Widget (FR4.2)
  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Close Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),

              // Flash/Light Toggle Button
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Flash toggled')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Scanning Indicator Widget
  Widget _buildScanningIndicator() {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AI Scanning...',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primaryAmber,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Scanning Overlay with Focus Area & Detection Chips (FR4.5)
  Widget _buildScanningOverlay(BuildContext context, Size screenSize) {
    final focusAreaWidth = screenSize.width * 0.7;
    final focusAreaHeight = focusAreaWidth * 1.2;

    return Positioned.fill(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Focus Area Box
            Container(
              width: focusAreaWidth,
              height: focusAreaHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryAmber, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // Detection Chip 1: Tomato
            Positioned(
              left: screenSize.width * 0.1,
              top: screenSize.height * 0.35,
              child: _buildDetectionChip('Tomato'),
            ),

            // Detection Chip 2: Onion
            Positioned(
              right: screenSize.width * 0.1,
              bottom: screenSize.height * 0.35,
              child: _buildDetectionChip('Onion'),
            ),
          ],
        ),
      ),
    );
  }

  // Detection Chip Widget
  Widget _buildDetectionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border.all(
          color: const Color(0xFFFFD700), // Golden/Yellow
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Bottom Control Panel (FR4.6)
  Widget _buildBottomControlPanel(BuildContext context, Size screenSize) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
        child: SafeArea(
          child: Column(
            children: [
              // Detection Status Text
              Text(
                '2 items detected • Tap to capture',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Capture Button & Side Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retake Button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Retaking image...')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // Capture Button (Large White Circle with Amber Ring)
                  GestureDetector(
                    onTap: _handleCapture,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryAmber,
                          width: 4,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryAmber.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryAmber,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Gallery Button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening gallery...')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
