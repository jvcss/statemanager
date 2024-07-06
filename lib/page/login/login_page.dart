

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/dialogs/generic_dialogs.dart';
import 'package:statemanager/helper/strings.dart';
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/page/loading/load_screen.dart';
import 'package:statemanager/page/login/login_hook.dart';
import 'package:statemanager/widget/list_screen.dart';

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

          if (state.isLoading == false && 
              state.loginError == null && 
              state.loginModel == const LoginModel.fooBar() && 
              state.notes == null) {
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
          return LoginView(
            onLoginTapped: (email, password) {
              context.read<AppBloc>().add(LoginEvent(
                    username: email,
                    password: password,
                  ));
              return state.isLoading;
            },
          );
        },
      ),
    );
  }
}