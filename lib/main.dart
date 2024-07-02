import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:statemanager/api.dart';
import 'package:statemanager/display_dynamic_view.dart';
import 'package:statemanager/lights_snackbar.dart';
import 'package:statemanager/provider.dart';

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
        '/': (BuildContext context) => ApiProvider(
              api: API(),
              child: const HomePage(),
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

// poderia ser usado dentro do widget HomePage
// mas para fins de demonstração, foi colocado aqui
// para mostrar que o estado do provider é preservado
void _changeTitle(BuildContext context) async {
  Timer.periodic(const Duration(seconds: 3), (timer) {
    //setState(() {
      //title = DateTime.now().toLocal().toString();
      final api = ApiProvider.of(context)!;
      // essa é a chamada que altera o estado do provider, que consequentemente atualiza o widget DisplayDynamicView
      // e que por consequência atualiza o widget HomePage
      // nao existe outra chamada além dessa que altera o estado do provider com um metodo
      // no widget DisplayDynamicView, apenas a referencia da variavel é diretamente atribuida ao widget
      // isso significa que o compartilhamento de context herdado por StatelessWidget e InheritedWidget do provider
      // a chamada da api é feita indiretamente e mesmo assim o valor é atualizado
      // uma boa demonstração de conservação de estado
      var dateAndTime = api?.api.getDateAndTime();
      //_textKey = ValueKey<String?>(api!.id);
    });
}

class _HomePageState extends State<HomePage> {
  //ValueKey _textKey = const ValueKey<String?>(null);
  String title = 'Home Page';

  @override
  void initState() {
    super.initState();
    _changeTitle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          ApiProvider.of(context)?.api.dateAndTime ?? title,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DisplayDynamicView(
              //   key: _textKey,
              ),
          GestureDetector(
            onTap: () async {
              showFancySnackbar(context);
              //final api = ApiProvider.of(context);
              // final dateAndTime = await api?.api.getDateAndTime(); // this is not so good. why?
              //because you need to reexcute the function to get the value
              // if its a heavy function, it will be a problem
              // most important if the business logic runs over a single instance
              // you can compromise the list of executions.

              setState(() {
                //title = ApiProvider.of(context)?.api.dateAndTime ?? 'Loading.';
                //_textKey = ValueKey<String?>(dateAndTime);
              });
            },
            child: Container(
              color: Theme.of(context).colorScheme.onBackground,
              child: Center(
                child: Text(
                  'Show case',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
          ),
        ],
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
