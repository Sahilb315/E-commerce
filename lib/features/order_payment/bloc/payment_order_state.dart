part of 'payment_order_bloc.dart';

@immutable
sealed class PaymentOrderState {}

abstract class PaymentActionOrderState extends PaymentOrderState {}

final class PaymentOrderInitial extends PaymentOrderState {}

class PaymentNavigateToCreditDebitPageOrderActionState extends PaymentActionOrderState {}

class PaymentNavigateToGooglePayPageOrderActionState extends PaymentActionOrderState {}

class PaymentNavigateToCashOnDeliveryPageOrderActionState
    extends PaymentActionOrderState {}
