// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterNavigateToLoginPageEvent>(registerNavigateToLoginPageEvent);
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  FutureOr<void> registerNavigateToLoginPageEvent(
      RegisterNavigateToLoginPageEvent event, Emitter<RegisterState> emit) {
    emit(RegisterNavigatToLoginPageActionState());
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<RegisterState> emit) {}
}
