import 'package:e_commerce_app/features/payment/bloc/payment_bloc.dart';
import 'package:e_commerce_app/features/credit_debit_card/ui/pages/credit_debit_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final paymentBloc = PaymentBloc();

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
      body: BlocListener<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        listenWhen: (previous, current) => current is PaymentActionState,
        listener: (context, state) {
          if (state is PaymentNavigateToCreditDebitPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
             const CreditDebitPage(),
            );
          } else if (state is PaymentNavigateToGooglePayPageActionState) {
          } else if (state is PaymentNavigateToCashOnDeliveryPageActionState) {}
        },
        child: Column(
          children: [
            ListTile(
              onTap: () {
                paymentBloc.add(PaymentNavigateToCreditDebitPageEvent());
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
