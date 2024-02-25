part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {}

class RegisterNavigateToLoginPageEvent extends RegisterEvent {}
