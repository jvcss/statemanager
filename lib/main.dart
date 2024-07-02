import 'dart:math' as math show Random;
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:statemanager/random_names.dart';

void main() {
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: Map<String, WidgetBuilder>.from({
          '/': (context) => const Page(title: 'Flutter Demo Home Page'),
        }));
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.title});

  final String title;

  @override
  State<Page> createState() => PageState();
}

class PageState extends State<Page> {
  late NamesCubit _namesCubit;

  @override
  void initState() {
    super.initState();
    _namesCubit = NamesCubit();
  }

  @override
  void dispose() {
    _namesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<String?>(
        stream: _namesCubit.stream,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Random Name: ${snapshot.data ?? 'Press the button to generate a name'}',
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _namesCubit.generateRandomName();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
