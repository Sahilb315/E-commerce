// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/repo/credit_card_repo.dart';
import 'package:meta/meta.dart';

part 'credit_debit_card_event.dart';
part 'credit_debit_card_state.dart';

class CreditDebitCardBloc
    extends Bloc<CreditDebitCardEvent, CreditDebitCardState> {
  CreditDebitCardBloc() : super(CreditDebitCardInitial()) {
    on<CreditDebitNavigateToAddNewCardPageEvent>(
        creditDebitNavigateToAddNewCardPageEvent);
    on<CreditDebitAddNewCardEvent>(creditDebitAddNewCardEvent);
    on<CreditDebitDeleteCardEvent>(creditDebitDeleteCardEvent);
    on<CreditDebitFetchCardsEvent>(creditDebitFetchCardsEvent);
    on<CreditDebitCardEmptyFieldEvent>(creditDebitCardEmptyFieldEvent);
    on<CreditDebitUpdateCardEvent>(creditDebitUpdateCardEvent);
    on<CreditDebitNavigateToPlaceOrderPageEvent>(
        creditDebitNavigateToPlaceOrderPageEvent);
  }

  final cardRepo = CreditCardRepo();

  FutureOr<void> creditDebitFetchCardsEvent(CreditDebitFetchCardsEvent event,
      Emitter<CreditDebitCardState> emit) async {
    final cardsList = await cardRepo.fetchAllCards();

    cardsList.isEmpty
        ? emit(CreditCardListEmptyState())
        : emit(CreditCardLoadedState(
            cardsList: cardsList,
          ));
  }

  FutureOr<void> creditDebitNavigateToAddNewCardPageEvent(
      CreditDebitNavigateToAddNewCardPageEvent event,
      Emitter<CreditDebitCardState> emit) {
    emit(CreditDebitNavigateToAddNewCardPageActionState());
  }

  FutureOr<void> creditDebitAddNewCardEvent(CreditDebitAddNewCardEvent event,
      Emitter<CreditDebitCardState> emit) async {
    await cardRepo.addNewCreditCard(event.cardModel);
    emit(CreditDebitCardAddedSuccessfullyActionState());
    final cardsList = await cardRepo.fetchAllCards();
    emit(CreditCardLoadedState(
      cardsList: cardsList,
    ));
  }

  FutureOr<void> creditDebitDeleteCardEvent(CreditDebitDeleteCardEvent event,
      Emitter<CreditDebitCardState> emit) async {}

  FutureOr<void> creditDebitCardEmptyFieldEvent(
      CreditDebitCardEmptyFieldEvent event,
      Emitter<CreditDebitCardState> emit) {
    emit(CreditDebitCardEmptyFieldActionState());
  }

  FutureOr<void> creditDebitUpdateCardEvent(CreditDebitUpdateCardEvent event,
      Emitter<CreditDebitCardState> emit) async {
    await cardRepo.updateSelectedAddress(event.cardModel);
    final cardsList = await cardRepo.fetchAllCards();

    emit(CreditCardLoadedState(
      cardsList: cardsList,
    ));
  }

  FutureOr<void> creditDebitNavigateToPlaceOrderPageEvent(
      CreditDebitNavigateToPlaceOrderPageEvent event,
      Emitter<CreditDebitCardState> emit) {
    emit(CreditDebitCardNavigateToPlaceOrderPageActionState());
  }
}
