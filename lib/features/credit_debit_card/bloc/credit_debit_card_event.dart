part of 'credit_debit_card_bloc.dart';

@immutable
sealed class CreditDebitCardEvent {}

class CreditDebitFetchCardsEvent extends CreditDebitCardEvent {}

class CreditDebitAddNewCardEvent extends CreditDebitCardEvent {
  final CreditDebitCardModel cardModel;

  CreditDebitAddNewCardEvent({required this.cardModel});
}

class CreditDebitDeleteCardEvent extends CreditDebitCardEvent {
  final CreditDebitCardModel cardModel;

  CreditDebitDeleteCardEvent({required this.cardModel});
}

class CreditDebitUpdateCardEvent extends CreditDebitCardEvent {
  final CreditDebitCardModel cardModel;

  CreditDebitUpdateCardEvent({required this.cardModel});
}

class CreditDebitNavigateToAddNewCardPageEvent extends CreditDebitCardEvent {}

class CreditDebitCardEmptyFieldEvent extends CreditDebitCardEvent {}

class CreditDebitNavigateToPlaceOrderPageEvent extends CreditDebitCardEvent {}
