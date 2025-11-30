import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class VoiceAssistantOverlay extends StatefulWidget {
  const VoiceAssistantOverlay({Key? key}) : super(key: key);

  @override
  State<VoiceAssistantOverlay> createState() => _VoiceAssistantOverlayState();
}

class _VoiceAssistantOverlayState extends State<VoiceAssistantOverlay> {
  String selectedLanguage = 'English'; // 'English' or 'Urdu'
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Title and Language Toggle (FR11.1)
                _buildHeader(context),
                const SizedBox(height: 32),

                // Microphone Visual (FR11.2)
                _buildMicrophoneVisual(context),
                const SizedBox(height: 32),

                // Quick Commands Grid (FR11.4)
                _buildQuickCommandsGrid(context),
                const SizedBox(height: 24),

                // Command Suggestions (FR11.5)
                _buildCommandSuggestions(context),
                const SizedBox(height: 16),

                // Close Button
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Widget (FR11.1)
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Voice Cooking Assistant',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Language Toggle (FR11.1)
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageButton(context, 'English'),
              _buildLanguageButton(context, 'Urdu'),
            ],
          ),
        ),
      ],
    );
  }

  // Language Button Widget
  Widget _buildLanguageButton(BuildContext context, String language) {
    final isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentViolet : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          language,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : AppColors.textCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Microphone Visual Widget (FR11.2)
  Widget _buildMicrophoneVisual(BuildContext context) {
    return Column(
      children: [
        // Animated Microphone Circle
        GestureDetector(
          onTap: () {
            setState(() {
              isListening = !isListening;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentViolet,
              boxShadow: isListening
                  ? [
                      BoxShadow(
                        color: AppColors.accentViolet.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Icon(Icons.mic, color: Colors.white, size: 60),
          ),
        ),
        const SizedBox(height: 16),
        // Text below microphone
        Text(
          'Tap to speak',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (isListening) ...[
          const SizedBox(height: 12),
          Text(
            'Listening...',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accentViolet,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  // Quick Commands Grid Widget (FR11.4)
  Widget _buildQuickCommandsGrid(BuildContext context) {
    final commands = [
      QuickCommand(
        label: 'Next',
        icon: Icons.skip_next,
        color: AppColors.highlightMint.withOpacity(0.2),
      ),
      QuickCommand(
        label: 'Previous',
        icon: Icons.skip_previous,
        color: AppColors.primaryAmber.withOpacity(0.2),
      ),
      QuickCommand(
        label: 'Repeat',
        icon: Icons.repeat,
        color: AppColors.accentViolet.withOpacity(0.2),
      ),
      QuickCommand(
        label: 'Timer',
        icon: Icons.timer,
        color: const Color(0xFFFFB3D9).withOpacity(0.5), // Pastel Pink
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: commands
          .map((cmd) => _buildCommandButton(context, cmd))
          .toList(),
    );
  }

  // Command Button Widget
  Widget _buildCommandButton(BuildContext context, QuickCommand command) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${command.label} command activated')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: command.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(command.icon, size: 40, color: AppColors.textCharcoal),
            const SizedBox(height: 8),
            Text(
              command.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textCharcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Command Suggestions Widget (FR11.5)
  Widget _buildCommandSuggestions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Say these commands: 'Next step', 'Previous step'",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Close Button Widget
  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAmber,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Close',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Quick Command Model
class QuickCommand {
  final String label;
  final IconData icon;
  final Color color;

  QuickCommand({required this.label, required this.icon, required this.color});
}
