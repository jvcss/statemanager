
import 'package:flutter/widgets.dart' show IconData, Color;

class SingleCardData {
  final String value;
  final String? label;
  final IconData? icon;
  final Color color;

  const SingleCardData({
    required this.value,
    this.label,
    this.icon,
    this.color = const Color(0xFF3B82F6),
  });
}