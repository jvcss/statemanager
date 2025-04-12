

import 'dart:ui' show Color;

class TableData {
  final List<String> headers;
  final List<List<String>> rows;
  final Color headerColor;
  final Color rowColor;

  const TableData({
    required this.headers,
    required this.rows,
    this.headerColor = const Color(0xFF1E88E5),
    this.rowColor = const Color(0xFFF5F5F5),
  });
}
