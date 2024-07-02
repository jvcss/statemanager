import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statemanager/random_names_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final StreamController<String?>? streamController;
  const MyApp({super.key, this.streamController});

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
          '/': (context) => MyPage(
                title: 'Flutter Demo Home Page',
                streamController: streamController,
              ),
        }));
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title, this.streamController});

  final String title;
  final StreamController<String?>? streamController;

  @override
  State<MyPage> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
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

  Stream<String?> stream() {
    // check if test
    if (widget.streamController != null) {
      widget.streamController!.add(_namesCubit.state);
      return widget.streamController!.stream;
    }
    return _namesCubit.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<String?>(
        stream: stream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              break;
            case ConnectionState.none:
              return const Center(child: Text('No data'));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Random Name'),
                Text(snapshot.data ?? 'Press the button to generate a name'),
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
