import 'dart:async';

import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
