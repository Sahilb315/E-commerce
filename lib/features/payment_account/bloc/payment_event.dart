part of 'payment_bloc.dart';

@immutable
sealed class PaymentAccountEvent {}

class PaymentNavigateToCreditDebitPageAccountEvent
    extends PaymentAccountEvent {}

class PaymentNavigateToGooglePayPageAccountEvent extends PaymentAccountEvent {}

class PaymentNavigateToCashOnDeliveryPageAccountEvent
    extends PaymentAccountEvent {}
