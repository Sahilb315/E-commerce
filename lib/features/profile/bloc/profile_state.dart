part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserModel userModel;

  ProfileLoadedState({required this.userModel});
}

class ProfileErrorState extends ProfileState {}
