import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/dialogs/generic_dialogs.dart';
import 'package:statemanager/helper/strings.dart';
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/page/loading/load_screen.dart';
import 'package:statemanager/widget/email_textfield.dart';
import 'package:statemanager/widget/extensions/list_screen.dart';
import 'package:statemanager/widget/extensions/login_button.dart';
import 'package:statemanager/widget/password_textfield.dart';
import 'dart:developer' as devtools show log;

class LoginPageVanilla extends StatelessWidget {
  const LoginPageVanilla({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    // Determine if we are running in a test environment
    bool isTestEnvironment = Platform.environment.containsKey('FLUTTER_TEST');

    return Scaffold(
        body: BlocConsumer<AppBloc, AppState>(
        listener: 
        (context, state) {
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
          if (state.isLoading == false && state.loginError == null && state.loginModel == const LoginModel.adminAccount() && state.notes == null) {
            context.read<AppBloc>().add(
                  const LoadNotesEvent(),
                );
          }
        },
        builder: (context, state) {
          final notes = state.notes;
          if (notes != null) {
            return notes.toListScreen();
          }
          return CustomScrollView(
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
                      onLoginTapped: (email, password) {
                        devtools.log('Email: $email');
                        devtools.log('Password: $password');
                        context.read<AppBloc>().add(LoginEvent(
                              username: email,
                              password: password,
                            ));
                        return state.isLoading;
                      },
                      emailField: emailController,
                      passwordField: passwordController,
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
    ));
  }
}
