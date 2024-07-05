import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Welcome to Flutter'),
            background: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/cripto-safe.appspot.com/o/MODO_SANIN_AI_GEMINI_CRYPTO_SAFE.jpg?alt=media&token=a4564b90-1e9d-43e4-bb07-85c3501f69f5',
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
              child: ElevatedButton(
                onPressed: () {
                  devtools.log('Email: ${emailController.text}');
                  devtools.log('Password: ${passwordController.text}');
                },
                child: const Text('Login'),
              ),
            ),
          ]),
        ),
      ],
    ));
  }
}
