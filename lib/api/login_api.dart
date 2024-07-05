import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanager/model/login_model.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginModel?> login({
    required String username,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  const LoginApi._sharedInstance(); // ! singleton
  static const LoginApi _shared = LoginApi._sharedInstance();
  factory LoginApi() => _shared;

  @override
  Future<LoginModel?> login({
    required String username,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => username == 'admin' && password == 'admin',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginModel.fooBar() : null,
      );
}
