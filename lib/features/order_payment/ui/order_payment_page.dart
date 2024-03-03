import 'package:e_commerce_app/features/credit_debit_card/ui/pages/order_payment_pages/order_cards_page.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/order_payment/bloc/payment_order_bloc.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrderPaymentPage extends StatelessWidget {
  final ProductModel? productModel;
  OrderPaymentPage({super.key, this.productModel});

  final paymentBloc = PaymentOrderBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Payment",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: BlocListener<PaymentOrderBloc, PaymentOrderState>(
        bloc: paymentBloc,
        listenWhen: (previous, current) => current is PaymentActionOrderState,
        listener: (context, state) {
          if (state is PaymentNavigateToCreditDebitPageOrderActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              OrderCreditCardsPage(
                productModel: productModel,
              ),
            );
          } else if (state is PaymentNavigateToGooglePayPageOrderActionState) {
          } else if (state
              is PaymentNavigateToCashOnDeliveryPageOrderActionState) {}
        },
        child: Column(
          children: [
            ListTile(
              onTap: () {
                paymentBloc.add(PaymentNavigateToCreditDebitPageOrderEvent());
              },
              leading: SvgPicture.asset(
                "assets/payment/card.svg",
                width: 42,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  "Credit or Debit Card",
                  style: MyTextThemes.myTextTheme().titleSmall,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: SvgPicture.asset(
                "assets/payment/gpay.svg",
                width: 50,
              ),
              title: Text(
                "Google Pay",
                style: MyTextThemes.myTextTheme().titleSmall,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: SvgPicture.asset(
                "assets/payment/cash.svg",
                width: 50,
                height: 40,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Cash on Delivery",
                  style: MyTextThemes.myTextTheme().titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
