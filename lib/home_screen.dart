import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:statemanager/extensions.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription subscription;
  CountDown({required int from}) : super(from) {
    subscription = Stream.periodic(
      const Duration(seconds: 1),
      (i) => from - i,
    )
        .takeWhile(
          (value) => value >= 0,
        )
        .listen(
          (event) => value = event,
        );
  }
}
