// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/login/repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPageSignInButtonClickedEvent>(loginPageSignInButtonClickedEvent);
    on<LoginPageGoogleSignInButtonClickedEvent>(
      loginPageGoogleSignInButtonClickedEvent,
    );
    on<LoginPageNavigateToRegisterPageEvent>(
      loginPageNavigateToRegisterPageEvent,
    );
  }

  final loginRepo = LoginRepo();

  FutureOr<void> loginPageSignInButtonClickedEvent(
    LoginPageSignInButtonClickedEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginInvalidInputActionState());
    } else {
      log("Before loading");
      emit(LoginSuccessfulLoadingActionState());
      log("After loading");
      String successOrNot =
          await loginRepo.loginUser(event.email, event.password);
      log("After Login func");
      if (successOrNot.isEmpty) {
        emit(LoginSuccessfulActionState());
        log("After Login success ");
      } else {
        emit(LoginErrorActionState(errorMessage: successOrNot));
        log("After Login error");
      }
    }
  }

  FutureOr<void> loginPageGoogleSignInButtonClickedEvent(
    LoginPageGoogleSignInButtonClickedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginSuccessfulActionState());
    // If error show Snackbar
    emit(LoginErrorActionState(errorMessage: ""));
  }

  FutureOr<void> loginPageNavigateToRegisterPageEvent(
      event, Emitter<LoginState> emit) {
    emit(LoginPageNavigateToRegisterPageActionState());
  }
}
