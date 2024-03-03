// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:e_commerce_app/features/register/repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterNavigateToLoginPageEvent>(registerNavigateToLoginPageEvent);
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
    on<RegisterInvalidEmailEvent>(registerInvalidEmailEvent);
  }

  final registerRepo = RegisterRepo();

  FutureOr<void> registerNavigateToLoginPageEvent(
      RegisterNavigateToLoginPageEvent event, Emitter<RegisterState> emit) {
    emit(RegisterNavigatToLoginPageActionState());
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<RegisterState> emit) async {
    if (event.user.email.isEmpty ||
        event.user.fullName.isEmpty ||
        event.user.phoneNumber.isEmpty ||
        event.password.isEmpty) {
      emit(RegisterInvalidInputActionState());
    } else {
      // Register User
      String userCreatedOrNot =
          await registerRepo.registerUser(event.user, event.password);
      if (userCreatedOrNot.isEmpty) {
        emit(RegisterLoadingActionState());
        emit(RegisterSuccessfulActionState());
      } else {
        emit(RegisterErrorActionState(errorMessage: userCreatedOrNot));
      }
    }
  }

  FutureOr<void> registerInvalidEmailEvent(
      RegisterInvalidEmailEvent event, Emitter<RegisterState> emit) {
    emit(RegisterErrorActionState(errorMessage: "Invalid Email"));
  }
}
