import 'dart:typed_data';

import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanager/extensions/start_with.dart';

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
  bool operator ==(covariant AppState other) =>
   isLoading == other.isLoading && 
   (data ?? []).isEqualTo(other.data ?? []) &&
    error == other.error;

  @override
  int get hashCode => Object.hash(isLoading, data, error);
}
