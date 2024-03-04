import 'package:e_commerce_app/features/account/bloc/account_bloc.dart';
import 'package:e_commerce_app/features/address/ui/pages/address_page.dart';
import 'package:e_commerce_app/features/orders/ui/order_page.dart';
import 'package:e_commerce_app/features/payment_account/ui/pages/payment_account_page.dart';
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
  void initState() {
    accountBloc.add(AccountInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      bloc: accountBloc,
      buildWhen: (previous, current) => current is! AccountActionState,
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
        }
      },
      builder: (context, state) {
        if (state is AccountLoadedState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              title: const Text(
                'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: AppColors.backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userModel.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.userModel.email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          accountBloc.add(AccountNavigateToOrderPageEvent());
                        },
                        leading: Icon(
                          Iconsax.bag,
                          color: AppColors.backgroundColor.withOpacity(0.8),
                        ),
                        title: Text(
                          "Order",
                          style: MyTextThemes.myTextTheme().titleSmall,
                        ),
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
                        title: Text(
                          "Address",
                          style: MyTextThemes.myTextTheme().titleSmall,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          accountBloc.add(AccountNavigateToPaymentPageEvent());
                        },
                        leading: Icon(
                          CupertinoIcons.creditcard,
                          color: AppColors.backgroundColor.withOpacity(0.8),
                        ),
                        title: Text(
                          "Payment",
                          style: MyTextThemes.myTextTheme().titleSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is AccountLoadingState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.backgroundColor.withOpacity(0.7),
                strokeCap: StrokeCap.round,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
