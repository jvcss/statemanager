import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_state.dart';
import 'package:statemanager/page/dialogs/auth_error_dialog.dart';
import 'package:statemanager/page/loading/load_page.dart';
import 'package:statemanager/page/login/login_page.dart';
import 'package:statemanager/page/photo_gallery/photo_gallery_page.dart';
import 'package:statemanager/page/register/register_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc()..add(const AppEventInitialize()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter jvcss demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingPage().show(context: context, text: 'Loading...');
            } else {
              LoadingPage().hide();
            }
            final authError = state.authError;
            if (authError != null) {
              showDialogAuthError(authError: authError, context: context);
            }
          },
          builder: (context, state) {
            if (state is AppStateLoggedOut) {
              return const LoginPage();
            } else if (state is AppStateIsInRegistrationView) {
              return const RegisterPage();
            } else if (state is AppStateLoggedIn) {
              return const PhotoGalleryPage();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
