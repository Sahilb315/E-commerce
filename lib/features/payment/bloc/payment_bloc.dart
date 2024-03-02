import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentNavigateToCreditDebitPageEvent>(
        paymentNavigateToCreditDebitPageEvent);
    on<PaymentNavigateToGooglePayPageEvent>(
        paymentNavigateToGooglePayPageEvent);
    on<PaymentNavigateToCashOnDeliveryPageEvent>(
        paymentNavigateToCashOnDeliveryPageEvent);
  }

  FutureOr<void> paymentNavigateToCreditDebitPageEvent(
      PaymentNavigateToCreditDebitPageEvent event, Emitter<PaymentState> emit) {
    emit(PaymentNavigateToCreditDebitPageActionState());
  }

  FutureOr<void> paymentNavigateToGooglePayPageEvent(
      PaymentNavigateToGooglePayPageEvent event, Emitter<PaymentState> emit) {
    emit(PaymentNavigateToGooglePayPageActionState());
  }

  FutureOr<void> paymentNavigateToCashOnDeliveryPageEvent(
      PaymentNavigateToCashOnDeliveryPageEvent event,
      Emitter<PaymentState> emit) {
    emit(PaymentNavigateToCashOnDeliveryPageActionState());
  }
}
