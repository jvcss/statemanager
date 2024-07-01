import 'package:flutter/material.dart';
import 'package:statemanager/contact_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'State Manager 101',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 168, 107)),
          useMaterial3: true,
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const ContacstPage(),
          '/createContact': (BuildContext context) => CreateContact(controllerNewContact: TextEditingController()),
        });
  }
}
