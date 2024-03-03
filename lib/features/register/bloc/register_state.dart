part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterNavigatToLoginPageActionState extends RegisterActionState {}

class RegisterLoadingActionState extends RegisterActionState {}

class RegisterSuccessfulActionState extends RegisterActionState {}

class RegisterErrorActionState extends RegisterActionState {
  final String errorMessage;

  RegisterErrorActionState({required this.errorMessage});
}

class RegisterInvalidInputActionState extends RegisterActionState {}
