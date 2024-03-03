part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderState {}

abstract class PlaceOrderActionState extends PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoadingState extends PlaceOrderState {}

class PlaceOrderLoadedState extends PlaceOrderState {
  final List<CartModel> cartList;
  final AddressModel address;
  final CreditDebitCardModel cardModel;

  PlaceOrderLoadedState({
    required this.cartList,
    required this.address,
    required this.cardModel,
  });
}

class PlaceOrderErrorState extends PlaceOrderState {}

class PlaceOrderNavigateToOrderSUccessPageActionState
    extends PlaceOrderActionState {}
