import 'package:flutter/material.dart' show Color, Widget, Icons;

import 'package:statemanager/models/models.dart';

import 'package:statemanager/widgets/widgets.dart';

List<Widget> listCharts = [
  const FunnelChartWidget(
    width: 800,
    height: 400,
  ),
  const TreeMapChartWidget(
    width: 200,
    height: 200,
  ),
  const ScatterChartWidget(
    width: 200,
    height: 300,
  ),
  const BubbleChartWidget(
    width: 200,
    height: 300,
  ),
  const GaugeChartWidget(
    width: 200,
    height: 300,
  ),
  const SingleValueCardWidget(
    width: 200,
    height: 200,
    data: SingleCardData(
      value: 'R\$ 100',
      label: 'Total', //fff0f2
      color: Color(0xFF4CAF50), //Color(0xFFfff0f2),//
      icon: Icons.check_circle,
    ),
  ),
  const MultiValueCardWidget(
    width: 200,
    height: 280,
    data: MultiCardData(
      items: [
        MapEntry('Receita', 'R\$ 20K'),
        MapEntry('Lucro', 'R\$ 8K'),
        MapEntry('Crescimento', '12%'),
      ],
      color: Color(0xFF2E7D32),
      icon: Icons.dashboard,
      horizontal: false,
    ),
  ),
  const TableChartWidget(
    width: 200,
    height: 300,
    data: TableData(
      headers: ['Nome', 'Valor', 'Categoria'],
      rows: [
        ['Produto A', 'R\$ 120K', 'Eletrônicos'],
        ['Produto B', 'R\$ 90K', 'Casa'],
        ['Produto C', 'R\$ 45K', 'Papelaria'],
      ],
    ),
  ),
  const MatrixChartWidget(
    width: 200,
    height: 300,
    data: MatrixData(
      headers: ['Categoria', 'Valor'],
      rows: [
        MatrixRow([
          MatrixCell(label: 'Receita', indent: 0),
          MatrixCell(label: 'R\$ 100K')
        ]),
        MatrixRow([
          MatrixCell(label: '▸ Vendas', indent: 1),
          MatrixCell(label: 'R\$ 80K')
        ]),
        MatrixRow([
          MatrixCell(label: '▸ Serviços', indent: 1),
          MatrixCell(label: 'R\$ 20K')
        ]),
        MatrixRow([
          MatrixCell(label: 'Despesas', indent: 0),
          MatrixCell(label: 'R\$ 60K')
        ]),
        MatrixRow([
          MatrixCell(label: '▸ Operacionais', indent: 1),
          MatrixCell(label: 'R\$ 40K')
        ]),
        MatrixRow([
          MatrixCell(label: '▸ Administrativas', indent: 1),
          MatrixCell(label: 'R\$ 20K')
        ]),
      ],
    ),
  )
];
