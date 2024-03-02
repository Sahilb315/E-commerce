part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartModel> cartProducts;

  CartLoadedState({required this.cartProducts});
}

class CartErrorState extends CartState {}

class CartEmptyState extends CartState {}

class CartNavigateToProductDetailPageActionState extends CartActionState {
  final CartModel cartProduct;

  CartNavigateToProductDetailPageActionState({required this.cartProduct});
}

class CartNavigateToShippingPageActionState extends CartActionState {
  final List<CartModel> cartProducts;

  CartNavigateToShippingPageActionState({required this.cartProducts});
}