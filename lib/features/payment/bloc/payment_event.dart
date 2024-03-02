part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class PaymentNavigateToCreditDebitPageEvent extends PaymentEvent {}

class PaymentNavigateToGooglePayPageEvent extends PaymentEvent {}

class PaymentNavigateToCashOnDeliveryPageEvent extends PaymentEvent {}
