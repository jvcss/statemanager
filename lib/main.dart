import 'dart:io';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:statemanager/api/login/login_interface.dart';
import 'package:statemanager/api/note/notes_api_interface.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/dialogs/generic_dialogs.dart';
import 'package:statemanager/helper/strings.dart' show cryptosafelogo, homePage, loginErrorDialogMessage, loginErrorDialogTitle, logo, ok;
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/page/loading/load_screen.dart';
import 'package:statemanager/page/login/login_hook.dart';
import 'package:statemanager/page/login/login_page.dart';
import 'package:statemanager/page/login/login_stateless.dart';

import 'package:statemanager/widget/email_textfield.dart';
import 'package:statemanager/widget/login_button.dart';
import 'package:statemanager/widget/password_textfield.dart';
import 'package:statemanager/widget/list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
              );
            },
            child: true ? const LoginPageVanilla(): const LoginPage(),
          );
        },
      },
    );
  }
}
