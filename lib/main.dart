import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:statemanager/api/login/login_interface.dart';
import 'package:statemanager/api/note/notes_api_interface.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/page/login/login_page.dart';
import 'package:statemanager/page/login/login_stateless.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  final bool showSliver;
  const App({
    super.key,
    this.showSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) {
          return BlocProvider(
            create: (context) {
              return AppBloc(
                loginApi: LoginApi(),
                notesApi: NotesApi(),
                acceptableLoginModel: const LoginModel.adminAccount(),
              );
            },
            child: showSliver ? const LoginPageVanilla() : const LoginPage(),
          );
        },
      },
    );
  }
}
