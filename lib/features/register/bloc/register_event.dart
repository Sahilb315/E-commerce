part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {
  final UserModel user;
  final String password;

  RegisterButtonClickedEvent({required this.password, required this.user});
}

class RegisterNavigateToLoginPageEvent extends RegisterEvent {}
