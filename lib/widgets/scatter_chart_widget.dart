import 'package:flutter/material.dart';
import 'dart:math' as m;

import 'package:statemanager/models/point_data.dart';

class ScatterChartWidget extends StatelessWidget {
  final List<PointData>? data;
  final double width;
  final double height;

  ScatterChartWidget({
    super.key,
    this.data,
    required this.width,
    required this.height,
  });

  final List<PointData> mockData = [
    PointData(x: 1, y: 2, color: Colors.blue),
    PointData(x: 2, y: 4, color: Colors.green),
    PointData(x: 3, y: 1, color: Colors.red),
    PointData(x: 4, y: 3, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = data ?? mockData;
    final maxX = chartData.map((d) => d.x).reduce(m.max).toDouble() + 1;
    final maxY = chartData.map((d) => d.y).reduce(m.max).toDouble() + 1;

    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: CustomPaint(
        painter: ScatterChartPainter(chartData, maxX, maxY),
        child: Container(),
      ),
    );
  }
}

class ScatterChartPainter extends CustomPainter {
  final List<PointData> data;
  final double maxX;
  final double maxY;

  ScatterChartPainter(this.data, this.maxX, this.maxY);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in data) {
      final dx = (point.x / maxX) * size.width;
      final dy = size.height - (point.y / maxY) * size.height;
      paint.color = point.color.withOpacity(0.7);
      canvas.drawCircle(Offset(dx, dy), 8, paint);
    }

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
