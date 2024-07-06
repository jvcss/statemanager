
import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanager/model/login_model.dart';


part 'login_api.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginModel?> login({
    required String username,
    required String password,
  });
}