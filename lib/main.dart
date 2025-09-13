import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:statemanager/home.dart';
import 'package:rive/rive.dart' as rive;

void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(rive.RiveFile.file("assets/hero.riv"));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
      ),
      home: const SimpleAssetAnimation()// const HomePage(title: 'BI Visuals'),
    );
  }
}


class SimpleAssetAnimation extends StatelessWidget {
  const SimpleAssetAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: const Center(
        child: rive.RiveAnimation.asset(
          'assets/hero.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
