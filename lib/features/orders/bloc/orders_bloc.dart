// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/orders/repo/order_repo.dart';
import 'package:e_commerce_app/features/place_order/model/order_model.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<OrderInitialFetchEvent>(orderInitialFetchEvent);
  }

  OrderRepo orderRepo = OrderRepo();

  FutureOr<void> orderInitialFetchEvent(
      OrderInitialFetchEvent event, Emitter<OrdersState> emit) async {
    emit(OrderLoadingState());
    final orders = await orderRepo.getAllOrders();
    orders.isEmpty
        ? emit(OrderEmptyListState())
        : emit(OrderLoadedState(orders: orders));
  }
}
