part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class OrderLoadingState extends OrdersState {}

class OrderLoadedState extends OrdersState {
  final List<OrderModel> orders;

  OrderLoadedState({required this.orders});
}

class OrderEmptyListState extends OrdersState {}

class OrderErrorState extends OrdersState {}
