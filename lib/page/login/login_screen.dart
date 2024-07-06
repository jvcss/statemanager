import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:statemanager/widget/email_textfield.dart';
import 'package:statemanager/widget/login_button.dart';
import 'package:statemanager/widget/password_textfield.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView({
    super.key,
    required this.onLoginTapped,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(controller: emailController),
          const SizedBox(height: 8),
          PasswordTextField(controller: passwordController),
          const SizedBox(height: 8),
          LoginButton(
            emailField: emailController,
            passwordField: passwordController,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
