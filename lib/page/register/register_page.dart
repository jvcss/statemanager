import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget, useScrollController, useTextEditingController;
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/extensions/if_debug.dart';
import 'dart:developer' as developer;

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'jvcs.mecatronica@gmail.com'.ifDebugging,
    );
    final passwordController = useTextEditingController(
      text: 'zzzzzzzzzz'.ifDebugging,
    );
    final scrollController = useScrollController();

    void scrollToFocusedInput(BuildContext context, FocusNode focusNode) {
      // Delay to ensure keyboard is already shown
      Future.delayed(const Duration(seconds: 1), () {
        final RenderObject? object = focusNode.context?.findRenderObject();
        if (object != null) {
          scrollController.position.ensureVisible(
            object,
            alignment: 0.6, // Scroll so that the widget is 30% from the top of the scroll view
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    final emailFocusNode = FocusNode();
    final passwordFocusNode = FocusNode();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/logo_bird_2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        onTap: () => scrollToFocusedInput(context, emailFocusNode),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onTap: () => scrollToFocusedInput(context, passwordFocusNode),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          developer.log('Email: $email, Password: $password');

                          context.read<AppBloc>().add(AppEventRegister(email: email, password: password));
                        },
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          context.read<AppBloc>().add(
                                const AppEventGoToLogin(),
                              );
                        },
                        child: const Text('Back to Login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
