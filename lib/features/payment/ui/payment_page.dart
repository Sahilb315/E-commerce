import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
      body: Column(
        children: [
          ListTile(
            onTap: () {},
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
              "assets/payment/visa.svg",
              width: 50,
            ),
            title: Text(
              "VISA",
              style: MyTextThemes.myTextTheme().titleSmall,
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
              "assets/payment/paytm.svg",
              width: 50,
            ),
            title: Text(
              "Paytm",
              style: MyTextThemes.myTextTheme().titleSmall,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(
              "assets/payment/paypal.svg",
              width: 50,
            ),
            title: Text(
              "Paypal",
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
    );
  }
}

//  static void navigateToScreen(BuildContext context, Widget screen) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => screen),
  //   );
  // }