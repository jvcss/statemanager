part of 'app_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginError;
  final Iterable<Note>? notes;
  final LoginModel? loginModel;

  const AppState.initialState()
      : isLoading = false,
        loginError = null,
        notes = null,
        loginModel = null;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.notes,
    required this.loginModel,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': loginError,
        'notes': notes,
        'loginModel': loginModel,
      }.toString();

  // * all the parameters are required,
  // * so we can use the copyWith method to create a new instance of AppState
  AppState copyWith({
    required bool isLoading,
    LoginErrors? loginError,
    Iterable<Note>? notes,
    LoginModel? loginModel,
  }) {
    return AppState(
      isLoading: isLoading,
      loginError: loginError ?? this.loginError, // * null-aware operator, if loginError is null, use this.loginError
      notes: notes ?? this.notes,
      loginModel: loginModel ?? this.loginModel,
    );
  }

  @override
  bool operator ==(covariant AppState other) {
    final otherProps = isLoading.isEqualTo(other.isLoading) &&
     loginError == other.loginError &&
      loginModel == other.loginModel;
    if (notes == null && other.notes == null) {
      return otherProps;
    } else {
      return otherProps && (notes!.isEqualTo(other.notes));
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        loginError,
        notes,
        loginModel,
      );
}

extension UnorderedEquality on Object {
  bool isEqualTo(other) {
    return const DeepCollectionEquality.unordered().equals(this, other);
  }
}
