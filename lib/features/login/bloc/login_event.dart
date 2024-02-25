part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginPageSignInButtonClickedEvent extends LoginEvent {}

class LoginPageGoogleSignInButtonClickedEvent extends LoginEvent {}

class LoginPageNavigateToRegisterPageEvent extends LoginEvent {}
