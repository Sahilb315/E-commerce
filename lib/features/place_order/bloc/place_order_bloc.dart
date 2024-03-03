import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:e_commerce_app/features/place_order/repo/place_order_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(PlaceOrderInitial()) {
    on<PlaceOrderFetchEvent>(placeOrderFetchEvent);
    on<PlaceOrderButtonClickedEvent>(placeOrderButtonClickedEvent);
  }

  final placeOrderRepo = PlaceOrderRepo();

  FutureOr<void> placeOrderFetchEvent(
      PlaceOrderFetchEvent event, Emitter<PlaceOrderState> emit) async {
    emit(PlaceOrderLoadingState());
    final cartList = await placeOrderRepo.getCartItems();
    final address = await placeOrderRepo.getCurrentAddress();
    final paymentOption =
        await placeOrderRepo.getCurrentPaymentOptionSelected();
    emit(PlaceOrderLoadedState(
      cartList: cartList,
      address: address,
      cardModel: paymentOption,
    ));
  }

  FutureOr<void> placeOrderButtonClickedEvent(
      PlaceOrderButtonClickedEvent event, Emitter<PlaceOrderState> emit) {
    emit(PlaceOrderNavigateToOrderSUccessPageActionState());
  }
}
