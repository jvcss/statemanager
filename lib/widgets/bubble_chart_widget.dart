import 'package:flutter/material.dart';
import 'dart:math' as m;
class BubbleData {
  final int x;
  final int y;
  final double size;
  final Color color;
  const BubbleData({required this.x, required this.y, required this.size, required this.color});
}

class BubbleChartWidget extends StatefulWidget {
  const BubbleChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.opacity = 0.6,
    this.showBorder = true,
    this.maxBubbleSize = 30.0,
  });

  final double? width;
  final double? height;
  final List<BubbleData>? data;
  final double opacity;
  final bool showBorder;
  final double maxBubbleSize;

  @override
  State<BubbleChartWidget> createState() => _BubbleChartWidgetState();
}

class _BubbleChartWidgetState extends State<BubbleChartWidget> {
  final List<BubbleData> mockData = const [
    BubbleData(x: 1, y: 2, size: 20, color: Colors.blue),
    BubbleData(x: 2, y: 4, size: 30, color: Colors.green),
    BubbleData(x: 3, y: 1, size: 10, color: Colors.red),
    BubbleData(x: 4, y: 3, size: 25, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final maxX = chartData.map((d) => d.x).reduce(m.max).toDouble() + 1;
    final maxY = chartData.map((d) => d.y).reduce(m.max).toDouble() + 1;
    final maxSize = chartData.map((d) => d.size).reduce(m.max);

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
            painter: _BubbleChartPainter(
              data: chartData,
              maxX: maxX,
              maxY: maxY,
              maxSize: maxSize,
              maxBubbleSize: widget.maxBubbleSize,
              opacity: widget.opacity,
              showBorder: widget.showBorder,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _BubbleChartPainter extends CustomPainter {
  final List<BubbleData> data;
  final double maxX;
  final double maxY;
  final double maxSize;
  final double maxBubbleSize;
  final double opacity;
  final bool showBorder;

  _BubbleChartPainter({
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.maxSize,
    required this.maxBubbleSize,
    required this.opacity,
    required this.showBorder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in data) {
      final dx = (point.x / maxX) * size.width;
      final dy = size.height - (point.y / maxY) * size.height;
      final radius = (point.size / maxSize) * maxBubbleSize;
      paint.color = point.color.withOpacity(opacity);
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }

    if (showBorder) {
      final borderPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
