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
    on<CartAddProductEvent>(cartAddProductEvent);
    on<CartRemoveProductEvent>(cartRemoveProductEvent);
    on<CartDeleteAllProductEvent>(cartDeleteAllProductEvent);
    on<CartNavigateToProductDetailsPageEvent>(
        cartNavigateToProductDetailsPageEvent);
    on<CartNavigateToShippingPageEvent>(cartNavigateToShippingPageEvent);
  }
  final cartRepo = CartRepo();
  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    final cartProducts = await cartRepo.fetchCartProducts();
    cartProducts.isNotEmpty
        ? emit(CartLoadedState(cartProducts: cartProducts))
        : emit(CartEmptyState());
  }

  FutureOr<void> cartAddProductEvent(
      CartAddProductEvent event, Emitter<CartState> emit) async {
    await cartRepo.incrementCartItem(event.cartModel);
    final cartProducts = await cartRepo.fetchCartProducts();
    cartProducts.isNotEmpty
        ? emit(CartLoadedState(cartProducts: cartProducts))
        : emit(CartEmptyState());
  }

  FutureOr<void> cartRemoveProductEvent(
      CartRemoveProductEvent event, Emitter<CartState> emit) async {
    await cartRepo.decrementCartItem(event.cartModel);
    final cartProducts = await cartRepo.fetchCartProducts();
    cartProducts.isNotEmpty
        ? emit(CartLoadedState(cartProducts: cartProducts))
        : emit(CartEmptyState());
  }

  FutureOr<void> cartDeleteAllProductEvent(
      CartDeleteAllProductEvent event, Emitter<CartState> emit) async {
    await cartRepo.deleteAllCartItem(event.cartModel);
    final cartProducts = await cartRepo.fetchCartProducts();
    cartProducts.isNotEmpty
        ? emit(CartLoadedState(cartProducts: cartProducts))
        : emit(CartEmptyState());
  }

  FutureOr<void> cartNavigateToProductDetailsPageEvent(
      CartNavigateToProductDetailsPageEvent event, Emitter<CartState> emit) {
    emit(CartNavigateToProductDetailPageActionState(
      cartProduct: event.cartProduct,
    ));
  }

  FutureOr<void> cartNavigateToShippingPageEvent(
      CartNavigateToShippingPageEvent event, Emitter<CartState> emit) {
    emit(CartNavigateToShippingPageActionState(
        cartProducts: event.cartProducts));
  }
}
