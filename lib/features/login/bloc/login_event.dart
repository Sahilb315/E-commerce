part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginPageSignInButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginPageSignInButtonClickedEvent({required this.email, required this.password});

}

class LoginPageGoogleSignInButtonClickedEvent extends LoginEvent {}

class LoginPageNavigateToRegisterPageEvent extends LoginEvent {}
