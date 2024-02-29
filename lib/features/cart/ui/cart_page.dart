// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/ui/widgets/cart_tile.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case CartLoadedState:
              final successState = state as CartLoadedState;
              final cartProducts = successState.cartProducts;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Cart",
                          style: MyTextThemes.myTextTheme().titleMedium,
                        ),
                        const Icon(CupertinoIcons.bell),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return CartTile(
                          cartProduct: cartProducts[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            case CartErrorState:
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
