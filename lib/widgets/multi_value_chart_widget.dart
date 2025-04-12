import 'package:flutter/material.dart';

import 'package:statemanager/models/multi_card_data.dart';


class MultiValueCardWidget extends StatefulWidget {
  const MultiValueCardWidget({
    super.key,
    this.width,
    this.height,
    this.data,
  });

  final double? width;
  final double? height;
  final MultiCardData? data;

  @override
  State<MultiValueCardWidget> createState() => _MultiValueCardWidgetState();
}

class _MultiValueCardWidgetState extends State<MultiValueCardWidget> {
  final MultiCardData mockData = const MultiCardData(
    items: [
      MapEntry('Receita', 'R\$ 20K'),
      MapEntry('Lucro', 'R\$ 8K'),
      MapEntry('Crescimento', '12%'),
    ],
    color: Color(0xFF2E7D32),
    icon: Icons.dashboard,
    horizontal: false,
  );

  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? mockData;

    final content = data.items.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: 
            Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Colors.white70,
                ),
          ),
          FittedBox(
            child: Text(
              entry.value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    }).toList();

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        color: data.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.icon != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Icon(data.icon, color: Colors.white, size: 28),
                ),
              data.horizontal
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: content,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
