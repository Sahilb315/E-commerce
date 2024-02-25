part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

class LoginSuccessfulActionState extends LoginActionState {}

class LoginErrorActionState extends LoginActionState {}

class LoginPageNavigateToRegisterPageActionState extends LoginActionState {}
