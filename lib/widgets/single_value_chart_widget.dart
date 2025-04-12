import 'package:flutter/material.dart';

import 'package:statemanager/models/single_card_data.dart';

class SingleValueCardWidget extends StatelessWidget {
  const SingleValueCardWidget({
    super.key,
    required this.data,
    this.width = 200,
    this.height = 120,
  });

  final double width;
  final double height;
  final SingleCardData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: data.color,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (data.icon != null)
                Icon(data.icon, color: Colors.white, size: 28),
              FittedBox(
                child: Text(
                  data.value,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (data.label != null)
                Text(
                  data.label!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Outfit',
                        color: Colors.white70,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
