import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:statemanager/countdown.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CountDown counter = useMemoized(() => CountDown(from: 20));
    final notify = useListenable(counter);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Text(
        'Countdown: ${notify.value.toString()}',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
