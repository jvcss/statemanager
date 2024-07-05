import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show cryptosafelogo, logo;
import 'dart:developer' as devtools show log;

import 'package:statemanager/widget/email_textfield.dart';
import 'package:statemanager/widget/login_button.dart';
import 'package:statemanager/widget/password_textfield.dart';

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
      home: const Page(),
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
