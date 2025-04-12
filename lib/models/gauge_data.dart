import 'package:flutter/material.dart';

class GaugeData {
  final double value;
  final double maxValue;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final bool showText;
  final String? label;

  const GaugeData({
    required this.value,
    this.maxValue = 100,
    this.color = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.strokeWidth = 20.0,
    this.showText = true,
    this.label,
  });

  double get percent => (value / maxValue).clamp(0.0, 1.0);
}
