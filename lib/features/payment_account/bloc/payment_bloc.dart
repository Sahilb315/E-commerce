import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentAccountBloc
    extends Bloc<PaymentAccountEvent, PaymentAccountState> {
  PaymentAccountBloc() : super(PaymentInitial()) {
    on<PaymentNavigateToCreditDebitPageAccountEvent>(
        paymentNavigateToCreditDebitPageAccountEvent);
    on<PaymentNavigateToGooglePayPageAccountEvent>(
        paymentNavigateToGooglePayPageAccountEvent);
    on<PaymentNavigateToCashOnDeliveryPageAccountEvent>(
        paymentNavigateToCashOnDeliveryPageAccountEvent);
  }

  FutureOr<void> paymentNavigateToCreditDebitPageAccountEvent(
      PaymentNavigateToCreditDebitPageAccountEvent event,
      Emitter<PaymentAccountState> emit) {
    emit(PaymentNavigateToCreditDebitPageActionState());
  }

  FutureOr<void> paymentNavigateToGooglePayPageAccountEvent(
      PaymentNavigateToGooglePayPageAccountEvent event,
      Emitter<PaymentAccountState> emit) {
    emit(PaymentNavigateToGooglePayPageActionState());
  }

  FutureOr<void> paymentNavigateToCashOnDeliveryPageAccountEvent(
      PaymentNavigateToCashOnDeliveryPageAccountEvent event,
      Emitter<PaymentAccountState> emit) {
    emit(PaymentNavigateToCashOnDeliveryPageActionState());
  }
}
