import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
    );
  }
}
