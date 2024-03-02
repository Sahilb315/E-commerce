part of 'payment_bloc.dart';

@immutable
sealed class PaymentAccountState {}

abstract class PaymentActionState extends PaymentAccountState {}

final class PaymentInitial extends PaymentAccountState {}

class PaymentNavigateToCreditDebitPageActionState extends PaymentActionState {}

class PaymentNavigateToGooglePayPageActionState extends PaymentActionState {}

class PaymentNavigateToCashOnDeliveryPageActionState
    extends PaymentActionState {}
