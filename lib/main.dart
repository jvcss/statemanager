import 'package:flutter/material.dart';
import 'package:statemanager/random_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          '/': (context) => const MyPage(title: 'Flutter Demo Home Page'),
        }));
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title});

  final String title;

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
                const Text(
                  'Random Name',
                ),
                Text(snapshot.data ?? 'Press the button to generate a name')
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
