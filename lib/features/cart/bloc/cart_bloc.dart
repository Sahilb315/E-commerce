// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/cart/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
  }
  final cartRepo = CartRepo();
  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    final cartProducts = await cartRepo.fetchCartProducts();
    emit(CartLoadedState(cartProducts: cartProducts));
  }
}
