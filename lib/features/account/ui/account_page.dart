import 'package:e_commerce_app/features/account/bloc/account_bloc.dart';
import 'package:e_commerce_app/features/address/ui/pages/address_page.dart';
import 'package:e_commerce_app/features/orders/ui/order_page.dart';
import 'package:e_commerce_app/features/payment_account/ui/pages/payment_account_page.dart';
import 'package:e_commerce_app/features/profile/ui/profile_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final accountBloc = AccountBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: BlocListener<AccountBloc, AccountState>(
        bloc: accountBloc,
        listenWhen: (previous, current) => current is AccountActionState,
        listener: (context, state) {
          if (state is AccountNavigateToAddressPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const AddressPage(),
            );
          } else if (state is AccountNavigateToOrderPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const OrderPage(),
            );
          } else if (state is AccountNavigateToPaymentPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              PaymentAccountPage(),
            );
          } else if (state is AccountNavigateToProfilePageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const ProfilePage(),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    accountBloc.add(AccountNavigateToProfilePageEvent());
                  },
                  leading: Icon(
                    CupertinoIcons.person,
                    color: AppColors.backgroundColor.withOpacity(0.8),
                  ),
                  title: Text("Profile",
                      style: MyTextThemes.myTextTheme().titleSmall),
                ),
                ListTile(
                  onTap: () {
                    accountBloc.add(AccountNavigateToOrderPageEvent());
                  },
                  leading: Icon(
                    Iconsax.bag,
                    color: AppColors.backgroundColor.withOpacity(0.8),
                  ),
                  title: Text("Order",
                      style: MyTextThemes.myTextTheme().titleSmall),
                ),
                ListTile(
                  onTap: () {
                    accountBloc.add(AccountNavigateToAddressPageEvent());
                  },
                  leading: Icon(
                    // Icons.location_on_outlined,
                    Iconsax.location,
                    color: AppColors.backgroundColor.withOpacity(0.8),
                  ),
                  title: Text("Address",
                      style: MyTextThemes.myTextTheme().titleSmall),
                ),
                ListTile(
                  onTap: () {
                    accountBloc.add(AccountNavigateToPaymentPageEvent());
                  },
                  leading: Icon(
                    CupertinoIcons.creditcard,
                    color: AppColors.backgroundColor.withOpacity(0.8),
                  ),
                  title: Text("Payment",
                      style: MyTextThemes.myTextTheme().titleSmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
