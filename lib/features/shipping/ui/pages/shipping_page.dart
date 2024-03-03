// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/address/ui/widget/address_text_field.dart';
import 'package:e_commerce_app/features/address/ui/widget/address_tile.dart';
import 'package:e_commerce_app/features/order_payment/ui/order_payment_page.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/features/shipping/bloc/shipping_bloc.dart';
import 'package:e_commerce_app/features/shipping/ui/pages/add_address_ship_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key,});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final shippingBloc = ShippingBloc();
  @override
  void initState() {
    shippingBloc.add(ShippingFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Ship To",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              color: AppColors.backgroundColor.withOpacity(0.8),
            ),
            onPressed: () {
              shippingBloc.add(ShippingNavigateToAddNewAddressPageEvent());
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              CustomButton(
                heading: "Next",
                onTap: () {
                  shippingBloc.add(ShippingNavigateToPaymentPageEvent());
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<ShippingBloc, ShippingState>(
        bloc: shippingBloc,
        listenWhen: (previous, current) => current is ShippingActionState,
        buildWhen: (previous, current) => current is! ShippingActionState,
        listener: (context, state) {
          if (state is ShippingEditAddressBottomSheetActionState) {
            final address = state.address;

            final nameController = TextEditingController(text: address.name);
            final phoneNumberController =
                TextEditingController(text: address.phoneNumber);
            final addressController =
                TextEditingController(text: address.address);

            editShipAddressBottomSheet(context, nameController,
                phoneNumberController, addressController, address);
          } else if (state is ShippingNewAddressInvalidTypeEvent) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all fields"),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ShippingNavigateToAddNewAddressPageActionState) {
            HelperFunctions.pushReplacementNavigateToScreenUpDownAnimation(
              context,
              AddAdressShippingPage(
                
              ),
            );
          } else if (state is ShippingNavigateToPaymentPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              OrderPaymentPage(),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ShippingLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case ShippingEmptyAddressListState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 80,
                      "assets/address.svg",
                    ),
                    Text(
                      "No Address added...",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            case ShippingLoadedState:
              final addressList = (state as ShippingLoadedState).addresses;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return AddressTile(
                          addressModel: addressList[index],
                          onEditTap: () {
                            shippingBloc.add(ShippingEditBottomSheetEvent(
                              address: addressList[index],
                            ));
                          },
                          onDeleteTap: () {
                            shippingBloc.add(ShippingDeleteAddressEvent(
                              address: addressList[index],
                            ));
                          },
                          onAddressTap: () {
                            shippingBloc.add(ShippingOnTapAddressTileEvent(
                              address: addressList[index],
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            case ShippingErrorState:
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

  Future<void> editShipAddressBottomSheet(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController phoneNumberController,
    TextEditingController addressController,
    AddressModel address,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.55,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      AddressTextField(
                        hintText: "Name",
                        controller: nameController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddressTextField(
                        hintText: "Phone Number",
                        controller: phoneNumberController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddressTextField(
                        hintText: "Address",
                        controller: addressController,
                        showNumberTypeKeyboard: false,
                        showPhoneNumberTypeKeyboard: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        heading: "Update Address",
                        onTap: () {
                          if (nameController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              addressController.text.isEmpty) {
                            shippingBloc
                                .add(ShippingNewAddressInvalidTypeEvent());
                            return;
                          }
                          shippingBloc.add(
                            ShippingEditAddressEvent(
                              updateAddress: AddressModel(
                                name: nameController.text,
                                phoneNumber: phoneNumberController.text,
                                address: addressController.text,
                                isSelected: false,
                              ),
                              oldAddress: address,
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
