// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/account/repo/account_repo.dart';
import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountNavigateToAddressPageEvent>(accountNavigateToAddressPageEvent);
    on<AccountNavigateToOrderPageEvent>(accountNavigateToOrderPageEvent);
    on<AccountNavigateToProfilePageEvent>(accountNavigateToProfilePageEvent);
    on<AccountNavigateToPaymentPageEvent>(accountNavigateToPaymentPageEvent);
    on<AccountInitialFetchEvent>(accountInitialFetchEvent);
  }

  final accountRepo = AccountRepo();

  FutureOr<void> accountInitialFetchEvent(
      event, Emitter<AccountState> emit) async {
    log("Before loading");
    emit(AccountLoadingState());
    log("After loading");
    final user = await accountRepo.getUserInfo();
    log("After repo");
    emit(AccountLoadedState(userModel: user));
    log("After loaded");
  }

  FutureOr<void> accountNavigateToAddressPageEvent(
      AccountNavigateToAddressPageEvent event, Emitter<AccountState> emit) {
    emit(AccountNavigateToAddressPageActionState());
  }

  FutureOr<void> accountNavigateToOrderPageEvent(
      AccountNavigateToOrderPageEvent event, Emitter<AccountState> emit) {
    emit(AccountNavigateToOrderPageActionState());
  }

  FutureOr<void> accountNavigateToProfilePageEvent(
      AccountNavigateToProfilePageEvent event, Emitter<AccountState> emit) {
    emit(AccountNavigateToProfilePageActionState());
  }

  FutureOr<void> accountNavigateToPaymentPageEvent(
      AccountNavigateToPaymentPageEvent event, Emitter<AccountState> emit) {
    emit(AccountNavigateToPaymentPageActionState());
  }
}
