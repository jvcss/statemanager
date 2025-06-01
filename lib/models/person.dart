import 'package:flutter/foundation.dart'
    show immutable;
import 'package:statemanager/models/thing.dart';

@immutable
class Person extends Thing {
  final int age;
  final String team;
  final String email;

  const Person({
    required super.name,
    required this.age,
    required this.team,
    required this.email,
  });

  @override
  String toString() {
    return 'Person(name: $name, age: $age, team: $team, email: $email)';
  }

  factory Person.fromJson(
      Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
      team: json['team'] as String,
      email: json['email'] as String,
    );
  }

  @override
  Map<String, dynamic> toSearchableMap() {
    return {
      'name': name,
      'age': age,
      'team': team,
      'email': email,
    };
  }
}
