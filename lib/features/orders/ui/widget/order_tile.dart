// ignore_for_file: must_be_immutable

import 'package:e_commerce_app/features/orders/ui/widget/sperator_dash.dart';
import 'package:e_commerce_app/features/place_order/model/order_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final OrderModel orderModel;
  OrderTile({super.key, required this.orderModel});

  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < orderModel.itemsOrdered.length; i++) {
      int productQuantity = orderModel.itemsOrdered[i].totalItemCount!;
      totalPrice += productQuantity * orderModel.itemsOrdered[i].price;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderModel.orderId,
              style: MyTextThemes.myTextTheme().titleMedium,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Order at: ${orderModel.orderedAt.substring(0, 10)}",
              style: MyTextThemes.myTextTheme().bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const MySeparator(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Status",
                  style: MyTextThemes.myTextTheme().bodySmall,
                ),
                Text(
                  currentOrderStatus(),
                  style: MyTextThemes.myTextTheme().bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: MyTextThemes.myTextTheme().bodySmall,
                ),
                Text(
                  "${orderModel.itemsOrdered.length} items purchased",
                  style: MyTextThemes.myTextTheme().bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price",
                  style: MyTextThemes.myTextTheme().bodySmall,
                ),
                Text(
                  "\$$totalPrice",
                  style: MyTextThemes.myTextTheme().bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String currentOrderStatus() {
    String currentDate = DateTime.now().toString().substring(8, 10);
    String orderDate = orderModel.orderedAt.substring(8, 10);
    int daysGap = int.parse(currentDate) - int.parse(orderDate);

    String currentMonth = DateTime.now().toString().substring(5, 7);
    String orderMonth = orderModel.orderedAt.substring(5, 7);
    int monthGap = int.parse(currentMonth) - int.parse(orderMonth);

    String currentYear = DateTime.now().toString().substring(0, 4);
    String orderYear = orderModel.orderedAt.substring(0, 4);
    
    int yearGap = int.parse(currentYear) - int.parse(orderYear);

    if (monthGap >= 1 || yearGap >= 1) {
      return "Delivered";
    }
    if (daysGap <= 1) {
      return "Confirmed";
    } else if (daysGap > 1 && daysGap < 2) {
      return "Processing";
    } else if (daysGap >= 2 && daysGap < 3) {
      return "Shipping";
    } else {
      return "Delivered";
    }
  }
}
