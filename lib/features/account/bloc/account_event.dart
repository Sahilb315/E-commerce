part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class AccountNavigateToProfilePageEvent extends AccountEvent {}

class AccountNavigateToOrderPageEvent extends AccountEvent {}

class AccountNavigateToAddressPageEvent extends AccountEvent {}

class AccountNavigateToPaymentPageEvent extends AccountEvent {}
