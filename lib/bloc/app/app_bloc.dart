import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/utils/auth/auth_error.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_extensions.dart';
import 'package:statemanager/bloc/app/app_state.dart';
import 'package:statemanager/utils/upload_image.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateLoggedOut(isLoading: false)) {
    on<AppEventDeleteAccount>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      //start loading
      emit(AppStateLoggedIn(
        isLoading: true,
        user: user,
        firebaseReferences: state.firebaseReferences ?? [],
      ));

      //delete the user folder
      try {
        final folder = await FirebaseStorage.instance.ref(user.uid).listAll();

        await Future.wait(folder.items.map((e) => e.delete().catchError(onError)));
        await FirebaseStorage.instance.ref(user.uid).delete();

        await user.delete();

        await FirebaseAuth.instance.signOut();
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedIn(isLoading: false, user: user, firebaseReferences: state.firebaseReferences ?? [], authError: AuthError.from(e)));
      } on FirebaseException {
        emit(const AppStateLoggedOut(isLoading: false));
      }
    });

    on<AppEventGoToLogin>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
    });

    on<AppEventGoToRegistration>((event, emit) async {
      emit(const AppStateIsInRegistrationView(isLoading: false));
    });

    on<AppEventInitialize>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }

      final imageReferences = await _getUserFirebaseStorageReference(user.uid);

      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        firebaseReferences: imageReferences,
      ));
    });

    on<AppEventLogin>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));

      final email = event.email;
      final password = event.password;
      try {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user!;
        final imageReferences = await _getUserFirebaseStorageReference(user.uid);

        emit(AppStateLoggedIn(
          isLoading: false,
          user: user,
          firebaseReferences: imageReferences,
        ));
      } on FirebaseAuthException catch (e) {
        emit(
          AppStateLoggedOut(isLoading: false, authError: AuthError.from(e)),
        );
      } on FirebaseException {
        emit(const AppStateLoggedOut(isLoading: false));
      }
    });

    on<AppEventLogout>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      await FirebaseAuth.instance.signOut();
      emit(const AppStateLoggedOut(isLoading: false));
    });

    on<AppEventRegister>((event, emit) async {
      emit(const AppStateIsInRegistrationView(isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user!;

        emit(AppStateLoggedIn(
          isLoading: false,
          user: user,
          firebaseReferences: const [],
        ));
      } on FirebaseAuthException catch (e) {
        emit(AppStateIsInRegistrationView(isLoading: false, authError: AuthError.from(e)));
      }
    });

    on<AppEventUploadImage>((event, emit) async {
      final user = state.user;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      // * loading
      emit(AppStateLoggedIn(
        isLoading: true,
        user: user,
        firebaseReferences: state.firebaseReferences ?? [],
      ));

      final file = File(event.filePathToUpload);
      await uploadImage(filePathToUpload: file, userId: user.uid);

      final references = await _getUserFirebaseStorageReference(user.uid);

      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        firebaseReferences: references,
      ));
    });
  }

  Future<Iterable<Reference>> _getUserFirebaseStorageReference(String userId) async {
    return FirebaseStorage.instance.ref(userId).list().then((listResult) => listResult.items);
  }
}
