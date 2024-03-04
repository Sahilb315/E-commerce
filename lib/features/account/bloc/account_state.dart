part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

abstract class AccountActionState extends AccountState {}

final class AccountInitial extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final UserModel userModel;

  AccountLoadedState({required this.userModel});
}

class AccountNavigateToProfilePageActionState extends AccountActionState {}

class AccountNavigateToOrderPageActionState extends AccountActionState {}

class AccountNavigateToAddressPageActionState extends AccountActionState {}

class AccountNavigateToPaymentPageActionState extends AccountActionState {}
