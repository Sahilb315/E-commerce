import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/place_order/bloc/place_order_bloc.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessPage extends StatelessWidget {
  OrderSuccessPage({super.key});

  final placeOrderBloc = PlaceOrderBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: BlocListener(
        bloc: placeOrderBloc,
        listenWhen: (previous, current) => current is PlaceOrderActionState,
        listener: (context, state) {
          if (state is OrderSuccessNavigateToHomePageActionState) {
            HelperFunctions.pushReplacementNavigateToScreenUpDownAnimation(
              context,
              const BottomNavigationPage(
                index: 0,
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/animation/order-success.json",
                height: 250,
              ),
              const Text(
                "Payment Success!",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Your order will be shipped soon",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
                child: CustomButton(
                  heading: "Continue Shopping",
                  onTap: () {
                    placeOrderBloc.add(OrderSuccessNavigateToHomePageEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
