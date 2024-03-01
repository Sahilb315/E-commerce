part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartAddProductEvent extends CartEvent {
  final CartModel cartModel;

  CartAddProductEvent({required this.cartModel});
}

class CartRemoveProductEvent extends CartEvent {
  final CartModel cartModel;

  CartRemoveProductEvent({required this.cartModel});
}

class CartDeleteAllProductEvent extends CartEvent {
   final CartModel cartModel;

  CartDeleteAllProductEvent({required this.cartModel});
}

class CartNavigateToProductDetailsPageEvent extends CartEvent {}
