part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartModel> cartProducts;

  CartLoadedState({required this.cartProducts});
}

class CartErrorState extends CartState {}
