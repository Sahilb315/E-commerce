part of 'payment_order_bloc.dart';

@immutable
sealed class PaymentOrderEvent {}

class PaymentNavigateToCreditDebitPageOrderEvent extends PaymentOrderEvent {}

class PaymentNavigateToGooglePayPageOrderEvent extends PaymentOrderEvent {}

class PaymentNavigateToCashOnDeliveryPageOrderEvent extends PaymentOrderEvent {}

