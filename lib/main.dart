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
        '/': (BuildContext context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Material(
              color: Theme.of(context).colorScheme.inverseSurface,
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Home Page',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'Enter your username',
                  //hintText: 'Enter your name',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
