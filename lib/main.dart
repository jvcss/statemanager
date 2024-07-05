import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:statemanager/widget/email_textfield.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'Welcome to Flutter',
            ),
            EmailTextField(emailController: emailController),
            PasswordTextField(passwordController: passwordController),
            ElevatedButton(
              onPressed: () {
                devtools.log('Email: ${emailController.text}');
                devtools.log('Password: ${passwordController.text}');
              },
              child: const Text('Log in'),
            )
          ],
        ),
      ),
    );
  }
}
