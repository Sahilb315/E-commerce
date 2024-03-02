part of 'credit_debit_card_bloc.dart';

@immutable
sealed class CreditDebitCardState {}

abstract class CreditDebitCardActionState extends CreditDebitCardState {}

final class CreditDebitCardInitial extends CreditDebitCardState {}

class CreditCardLoadingState extends CreditDebitCardState {}

class CreditCardLoadedState extends CreditDebitCardState {
  final List<CreditDebitCardModel> cardsList;

  CreditCardLoadedState({required this.cardsList});
}

class CreditCardErrorState extends CreditDebitCardState {}

class CreditDebitNavigateToAddNewCardPageActionState
    extends CreditDebitCardActionState {}

class CreditDebitCardAddedSuccessfullyActionState
    extends CreditDebitCardActionState {}

class CreditDebitCardEmptyFieldActionState extends CreditDebitCardActionState {}
