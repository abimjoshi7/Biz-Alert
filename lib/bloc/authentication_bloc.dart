import 'dart:developer';

import 'package:biz_alert/bloc/authentication_repository.dart';
import 'package:biz_alert/constants/secure_constant.dart';
import 'package:biz_alert/constants/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepoistory;
  SharedPreferences? preferences;
  AuthenticationBloc(this.authenticationRepoistory)
      : super(AuthenticationLoading()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authenticationRepoistory.signInWithGoogle();
        FirebaseAuth? firebaseAuth;
        SecureStorage().writeData(
            key: saveNumber,
            value: firebaseAuth?.currentUser?.phoneNumber ?? "");
        SecureStorage().writeData(
            key: saveUserID, value: firebaseAuth?.currentUser?.uid ?? "");
        SecureStorage().writeData(
            key: saveToken,
            value: firebaseAuth?.currentUser?.getIdToken().toString() ?? "");
        emit(AuthenticationSuccess());
        log("Successful");
      } catch (e) {
        log("Failed");

        emit(
          AuthenticationError(e.toString()),
        );
        emit(AuthenticationFailed());
      }
    });

    on<FacebookSignInRequested>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authenticationRepoistory.signInWithFacebook();
        FirebaseAuth? firebaseAuth;
        SecureStorage().writeData(
            key: saveNumber,
            value: firebaseAuth?.currentUser?.phoneNumber ?? "");
        SecureStorage().writeData(
            key: saveUserID, value: firebaseAuth?.currentUser?.uid ?? "");
        SecureStorage().writeData(
            key: saveToken,
            value: firebaseAuth?.currentUser?.getIdToken().toString() ?? "");
        emit(AuthenticationSuccess());
        log("Successful");
      } catch (e) {
        log("Failed");

        emit(
          AuthenticationError(e.toString()),
        );
        emit(AuthenticationFailed());
      }
    });
  }
}
