import 'dart:typed_data';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  AppState copyWith({
    required bool? isLoading,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  const AppState.initialState()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() {
    return {
      'isLoading': isLoading,
      'hasData': data != null, // great idea, avoid printing large data if it exists
      'error': error,
    }.toString();
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppState && runtimeType == other.runtimeType && isLoading == other.isLoading;

  @override
  int get hashCode => isLoading.hashCode;
}
