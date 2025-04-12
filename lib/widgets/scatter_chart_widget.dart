import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/models/scatter_data.dart';

class ScatterChartWidget extends StatefulWidget {
  const ScatterChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.dotRadius = 8,
    this.dotOpacity = 0.7,
    this.showBorder = true,
  });

  final double? width;
  final double? height;
  final List<ScatterData>? data;
  final double dotRadius;
  final double dotOpacity;
  final bool showBorder;

  @override
  State<ScatterChartWidget> createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> {
  final List<ScatterData> mockData = const [
    ScatterData(x: 1, y: 2, color: Colors.blue),
    ScatterData(x: 2, y: 4, color: Colors.green),
    ScatterData(x: 3, y: 1, color: Colors.red),
    ScatterData(x: 4, y: 3, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final maxX = chartData.map((d) => d.x).reduce(math.max).toDouble() + 1;
    final maxY = chartData.map((d) => d.y).reduce(math.max).toDouble() + 1;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomPaint(
            painter: _ScatterChartPainter(
              data: chartData,
              maxX: maxX,
              maxY: maxY,
              radius: widget.dotRadius,
              opacity: widget.dotOpacity,
              showBorder: widget.showBorder,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _ScatterChartPainter extends CustomPainter {
  final List<ScatterData> data;
  final double maxX;
  final double maxY;
  final double radius;
  final double opacity;
  final bool showBorder;

  _ScatterChartPainter({
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.radius,
    required this.opacity,
    required this.showBorder,
  }) : assert(opacity >= 0.0 && opacity <= 1.0,
            'Opacity must be between 0.0 and 1.0');

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in data) {
      final dx = (point.x / maxX) * size.width;
      final dy = size.height - (point.y / maxY) * size.height;
      paint.color = point.color.withAlpha((opacity * 255).toInt());
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }

    if (showBorder) {
      final borderPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
