import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:statemanager/bloc/app/app_state.dart';

extension GetUser on AppState {
  User? get user => this is AppStateLoggedIn ? (this as AppStateLoggedIn).user : null;
}

extension GetFirebaseReferences on AppState {
  Iterable<Reference>? get firebaseReferences => this is AppStateLoggedIn ? (this as AppStateLoggedIn).firebaseReferences : null;
}

