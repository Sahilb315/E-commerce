// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/features/orders/ui/widget/order_tile.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final ordersBloc = OrdersBloc();

  @override
  void initState() {
    ordersBloc.add(OrderInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Your Orders",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: BlocConsumer(
        bloc: ordersBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case OrderLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case OrderEmptyListState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 80,
                      "assets/no-order.svg",
                    ),
                    Text(
                      "No Orders placed...",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            case OrderLoadedState:
              final orderList = (state as OrderLoadedState).orders;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return OrderTile(
                            orderModel: orderList[index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            case OrderErrorState:
              return const Center(
                child: Text("Error..."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
