import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statemanager/pages/home.dart';
import 'package:statemanager/util/countables.dart';
import 'package:statemanager/util/extensions.dart';


void main() {
  colors.random();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
