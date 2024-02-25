// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPageSignInButtonClickedEvent>(loginPageSignInButtonClickedEvent);
    on<LoginPageGoogleSignInButtonClickedEvent>(
        loginPageGoogleSignInButtonClickedEvent);
    on<LoginPageNavigateToRegisterPageEvent>(
        loginPageNavigateToRegisterPageEvent);
  }

  FutureOr<void> loginPageSignInButtonClickedEvent(
      LoginPageSignInButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginSuccessfulActionState());
    // If error show Snackbar 
    emit(LoginErrorActionState());
  }

  FutureOr<void> loginPageGoogleSignInButtonClickedEvent(
      LoginPageGoogleSignInButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginSuccessfulActionState());
    // If error show Snackbar 
    emit(LoginErrorActionState());
  }

  FutureOr<void> loginPageNavigateToRegisterPageEvent(
      event, Emitter<LoginState> emit) {
    emit(LoginPageNavigateToRegisterPageActionState());
  }
}
