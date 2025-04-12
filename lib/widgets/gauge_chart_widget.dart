import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/models/gauge_data.dart';

class GaugeChartWidget extends StatefulWidget {
  const GaugeChartWidget({
    super.key,
    this.width = 200.0,
    this.height = 200.0,
    this.data = const GaugeData(
      color: Colors.blue,
      backgroundColor: Colors.grey,
      strokeWidth: 20.0,
      showText: true,
      value: 0.7,
    ),
  });

  final double width;
  final double height;
  final GaugeData? data;

  @override
  State<GaugeChartWidget> createState() => _GaugeChartWidgetState();
}

class _GaugeChartWidgetState extends State<GaugeChartWidget> {
  final List<GaugeData> mockData = const [
    GaugeData(
      color: Colors.blue,
      backgroundColor: Colors.grey,
      strokeWidth: 20.0,
      showText: true,
      value: 0.7,
    ),
    GaugeData(
      color: Colors.green,
      backgroundColor: Colors.grey,
      strokeWidth: 20.0,
      showText: true,
      value: 0.5,
    ),
    GaugeData(
      color: Colors.red,
      backgroundColor: Colors.grey,
      strokeWidth: 20.0,
      showText: true,
      value: 0.3,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? mockData[0];
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
            painter: _GaugePainter(
              percent: data.percent,
              color: data.color,
              backgroundColor: data.backgroundColor,
              strokeWidth: data.strokeWidth,
            ),
            child: Center(
              child: data.showText
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(data.percent * 100).toInt()}%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontFamily: 'Outfit',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (data.label != null)
                          Text(
                            data.label!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontFamily: 'Outfit',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percent;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _GaugePainter({
    required this.percent,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(
        rect, startAngle, sweepAngle * percent, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
