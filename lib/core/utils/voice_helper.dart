import 'package:flutter/material.dart';
import '../../features/voice/presentation/widgets/voice_overlay.dart';

/// Helper function to show the Voice Assistant Overlay
void showVoiceAssistant(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const VoiceAssistantOverlay(),
  );
}
