// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:e_commerce_app/features/profile/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialFetchEvent>(_profileInitialFetchEvent);
  }

  ProfileRepo profileRepo = ProfileRepo();

  FutureOr<void> _profileInitialFetchEvent(
      ProfileInitialFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    UserModel user = await profileRepo.getUserInfo();
    emit(ProfileLoadedState(userModel: user));
  }
}
