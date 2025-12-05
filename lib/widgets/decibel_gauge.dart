import 'dart:math';
import 'package:flutter/material.dart';

class DecibelGauge extends StatelessWidget {
  final double decibel;
  final bool isRecording;
  final AnimationController pulseAnimation;

  const DecibelGauge({
    super.key,
    required this.decibel,
    required this.isRecording,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        final pulseScale = isRecording ? 1.0 + (pulseAnimation.value * 0.03) : 1.0;
        
        return Transform.scale(
          scale: pulseScale,
          child: SizedBox(
            width: 280,
            height: 280,
            child: CustomPaint(
              painter: _GaugePainter(
                decibel: decibel,
                isRecording: isRecording,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      decibel.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: _getDecibelColor(decibel),
                        shadows: [
                          Shadow(
                            color: _getDecibelColor(decibel).withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'dB',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getDecibelColor(double db) {
    if (db < 40) return const Color(0xFF06B6D4);
    if (db < 60) return const Color(0xFF22C55E);
    if (db < 80) return const Color(0xFFEAB308);
    if (db < 100) return const Color(0xFFF97316);
    return const Color(0xFFF43F5E);
  }
}

class _GaugePainter extends CustomPainter {
  final double decibel;
  final bool isRecording;

  _GaugePainter({
    required this.decibel,
    required this.isRecording,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // 배경 원호
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degreesToRadians(135),
      _degreesToRadians(270),
      false,
      bgPaint,
    );

    // 눈금 표시
    _drawTicks(canvas, center, radius);

    // 값 원호
    final progress = (decibel / 120).clamp(0.0, 1.0);
    final sweepAngle = 270 * progress;

    final gradient = SweepGradient(
      startAngle: _degreesToRadians(135),
      endAngle: _degreesToRadians(135 + sweepAngle),
      colors: [
        const Color(0xFF06B6D4),
        const Color(0xFF22C55E),
        const Color(0xFFEAB308),
        const Color(0xFFF97316),
        const Color(0xFFF43F5E),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final valuePaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degreesToRadians(135),
      _degreesToRadians(sweepAngle),
      false,
      valuePaint,
    );

    // 글로우 효과
    if (isRecording && decibel > 0) {
      final glowPaint = Paint()
        ..color = _getDecibelColor(decibel).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        _degreesToRadians(135),
        _degreesToRadians(sweepAngle),
        false,
        glowPaint,
      );
    }
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2;

    for (int i = 0; i <= 12; i++) {
      final angle = _degreesToRadians(135 + (270 / 12) * i);
      final tickLength = i % 3 == 0 ? 15 : 8;
      
      final start = Offset(
        center.dx + (radius - 25) * cos(angle),
        center.dy + (radius - 25) * sin(angle),
      );
      final end = Offset(
        center.dx + (radius - 25 - tickLength) * cos(angle),
        center.dy + (radius - 25 - tickLength) * sin(angle),
      );

      canvas.drawLine(start, end, tickPaint);

      // 숫자 표시 (0, 30, 60, 90, 120)
      if (i % 3 == 0) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${i * 10}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        
        final textOffset = Offset(
          center.dx + (radius - 50) * cos(angle) - textPainter.width / 2,
          center.dy + (radius - 50) * sin(angle) - textPainter.height / 2,
        );
        textPainter.paint(canvas, textOffset);
      }
    }
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  Color _getDecibelColor(double db) {
    if (db < 40) return const Color(0xFF06B6D4);
    if (db < 60) return const Color(0xFF22C55E);
    if (db < 80) return const Color(0xFFEAB308);
    if (db < 100) return const Color(0xFFF97316);
    return const Color(0xFFF43F5E);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.decibel != decibel || oldDelegate.isRecording != isRecording;
  }
}

