import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statemanager/lights_snackbar.dart';

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
    // Timer.periodic(const Duration(seconds: 59), (timer) {
    //   setState(() {
    //     title = DateTime.now().toLocal().toString();
    //   });
    // });
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
          showFancySnackbar(context);
          setState(() {
            title = 'Show case';
          });
        },
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Text(
              'Show case',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showFancySnackbar(BuildContext context) {
    const snackBar = SnackBar(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: LightsSnackbarContent(),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  
}
