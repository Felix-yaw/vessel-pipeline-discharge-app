import 'package:flutter/material.dart';

/// Paints a grid of vertical and horizontal lines over the background.
class GridPainter extends CustomPainter {
  final int columns;
  final double rows;
  final Color color;

  const GridPainter({
    required this.columns,
    required this.rows,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..strokeWidth = 2;

    for (var i = 0; i <= columns; i++) {
      final dx = size.width * i / columns;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    for (var i = 0; i <= rows; i++) {
      final dy = size.height * i / rows;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.columns != columns ||
        oldDelegate.rows != rows ||
        oldDelegate.color != color;
  }
}