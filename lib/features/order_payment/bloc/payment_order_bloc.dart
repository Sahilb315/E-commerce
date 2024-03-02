// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_order_event.dart';
part 'payment_order_state.dart';

class PaymentOrderBloc extends Bloc<PaymentOrderEvent, PaymentOrderState> {
  PaymentOrderBloc() : super(PaymentOrderInitial()) {
    on<PaymentNavigateToCreditDebitPageOrderEvent>(
        paymentNavigateToCreditDebitPageOrderEvent);
  }

  FutureOr<void> paymentNavigateToCreditDebitPageOrderEvent(
      PaymentNavigateToCreditDebitPageOrderEvent event,
      Emitter<PaymentOrderState> emit) {
    emit(PaymentNavigateToCreditDebitPageOrderActionState());
  }
}
