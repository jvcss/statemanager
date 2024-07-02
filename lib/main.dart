import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  final Color green = const Color.fromRGBO(1, 204, 160, 1);
  final Color backgroundColor = const Color.fromRGBO(26, 31, 36, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Manager 101',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        //brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomePage(
            //   title: 'Page',
            ),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  //final String title;
  const HomePage({
    super.key,
    //this.title = 'Home Page',
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Home Page';

  void _changeTitle() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        title = DateTime.now().toLocal().toString();
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _changeTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              'Go to Second Page',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
