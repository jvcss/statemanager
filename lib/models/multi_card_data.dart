
import 'package:flutter/widgets.dart' show IconData, Color;

class MultiCardData {
  final List<MapEntry<String, String>> items;
  final bool horizontal;
  final Color color;
  final IconData? icon;

  const MultiCardData({
    required this.items,
    this.horizontal = false,
    this.color = const Color(0xFF1E88E5),
    this.icon,
  });
}