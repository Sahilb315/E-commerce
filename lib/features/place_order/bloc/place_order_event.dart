part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderEvent {}

class PlaceOrderFetchEvent extends PlaceOrderEvent {}

class PlaceOrderButtonClickedEvent extends PlaceOrderEvent {}
