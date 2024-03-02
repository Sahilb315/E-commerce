part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

abstract class PaymentActionState extends PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentNavigateToCreditDebitPageActionState extends PaymentActionState {}

class PaymentNavigateToGooglePayPageActionState extends PaymentActionState {}

class PaymentNavigateToCashOnDeliveryPageActionState
    extends PaymentActionState {}
