import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
