import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class NoiseLevelIndicator extends StatelessWidget {
  final double decibel;
  final AppLocalizations l10n;

  const NoiseLevelIndicator({
    super.key,
    required this.decibel,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final level = _getNoiseLevel();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: level.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: level.color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            level.icon,
            color: level.color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            level.label,
            style: TextStyle(
              color: level.color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            level.example,
            style: TextStyle(
              color: level.color.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  _NoiseLevel _getNoiseLevel() {
    if (decibel < 40) {
      return _NoiseLevel(
        label: l10n.quiet,
        example: '(${l10n.whisper})',
        icon: Icons.volume_mute,
        color: const Color(0xFF06B6D4),
      );
    } else if (decibel < 60) {
      return _NoiseLevel(
        label: l10n.normal,
        example: '(${l10n.library})',
        icon: Icons.volume_down,
        color: const Color(0xFF22C55E),
      );
    } else if (decibel < 80) {
      return _NoiseLevel(
        label: l10n.loud,
        example: '(${l10n.conversation})',
        icon: Icons.volume_up,
        color: const Color(0xFFEAB308),
      );
    } else if (decibel < 100) {
      return _NoiseLevel(
        label: l10n.veryLoud,
        example: '(${l10n.traffic})',
        icon: Icons.volume_up,
        color: const Color(0xFFF97316),
      );
    } else {
      return _NoiseLevel(
        label: l10n.dangerous,
        example: '(${l10n.concert})',
        icon: Icons.warning,
        color: const Color(0xFFF43F5E),
      );
    }
  }
}

class _NoiseLevel {
  final String label;
  final String example;
  final IconData icon;
  final Color color;

  _NoiseLevel({
    required this.label,
    required this.example,
    required this.icon,
    required this.color,
  });
}

