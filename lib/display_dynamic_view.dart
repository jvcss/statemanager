import 'package:flutter/material.dart';
import 'package:statemanager/api.dart';
import 'package:statemanager/provider.dart';

class DisplayDynamicView extends StatelessWidget {
  const DisplayDynamicView({super.key});

  @override
  Widget build(BuildContext context) {
    final API? api = ApiProvider.of(context)?.api;
    return Text(
      api?.dateAndTime ?? 'Loading...',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}