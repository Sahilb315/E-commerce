part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {
  final UserModel user;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  RegisterButtonClickedEvent({
    required this.nameController,
    required this.phoneController,
    required this.passwordController,
    required this.emailController,
    required this.user,
  });
}

class RegisterNavigateToLoginPageEvent extends RegisterEvent {}

class RegisterInvalidEmailEvent extends RegisterEvent {}
