import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginModel {
  final String token;

  const LoginModel({
    required this.token,
  });

  const LoginModel.adminAccount() : token = 'adminToken';

  @override
  bool operator ==(covariant LoginModel other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginModel(token: $token)';
}

enum LoginErrors {
  invalidModel,
}
