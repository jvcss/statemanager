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
import 'package:statemanager/page/login/login_screen.dart';

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
            child: const LoginPage(),
          );
        },
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(homePage),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // take care of loading screen
          if (state.isLoading) {
            LoadingScreen().show(
              context: context,
              text: 'Logging in...',
            );
          } else {
            LoadingScreen().hide();
          }
          final loginError = state.loginError;
          if (loginError != null) {
            showGenericDialog(
              context: context,
              title: loginErrorDialogTitle,
              content: loginErrorDialogMessage,
              options: () => {ok: true},
            );
          }

          if (state.isLoading == false && state.loginError == null && state.loginModel == const LoginModel.fooBar() && state.notes == null) {
            context.read<AppBloc>().add(
                  const LoadNotesEvent(),
                );
          }
        },
        builder: (context, state) {
          final notes = state.notes;
          if (notes != null) {
            return LoginView(
              onLoginTapped: (email, password) {
                context.read<AppBloc>().add(LoginEvent(
                      username: email,
                      password: password,
                    ));
                return true;
              },
            );
          } else {
            return notes!.toListScreen();
          }
        },
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    // Determine if we are running in a test environment
    bool isTestEnvironment = Platform.environment.containsKey('FLUTTER_TEST');

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 500.0,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Welcome to Flutter',
              locale: Locale('en', 'US'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            background: isTestEnvironment
                ? logo
                : Image.network(
                    cryptosafelogo,
                    fit: BoxFit.cover,
                  ),
          ),
          floating: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(
                left: 14.0,
                top: 14.0,
                right: 14.0,
                bottom: 0.0,
              ),
              child: EmailTextField(
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: PasswordTextField(controller: passwordController),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: LoginButton(
                onLoginTapped: (e, s) {
                  devtools.log('Email: $e');
                  devtools.log('Password: $s');
                  return e == s;
                },
                emailField: emailController,
                passwordField: passwordController,
              ),
              //   ElevatedButton(
              //   onPressed: () {
              //     devtools.log('Email: ${emailController.text}');
              //     devtools.log('Password: ${passwordController.text}');
              //   },
              //   child: const Text('Login'),
              // ),
            ),
          ]),
        ),
      ],
    ));
  }
}
