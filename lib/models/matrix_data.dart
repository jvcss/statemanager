import 'dart:ui' show Color;

class MatrixCell {
  final String label;
  final int indent;

  const MatrixCell({required this.label, this.indent = 0});
}

class MatrixRow {
  final List<MatrixCell> cells;

  const MatrixRow(this.cells);
}

class MatrixData {
  final List<String> headers;
  final List<MatrixRow> rows;
  final Color headerColor;
  final Color rowColor;

  const MatrixData({
    required this.headers,
    required this.rows,
    this.headerColor = const Color(0xFF1565C0),
    this.rowColor = const Color(0xFFF5F5F5),
  });
}