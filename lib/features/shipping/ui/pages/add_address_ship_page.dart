// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/address/ui/widget/address_text_field.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/features/shipping/bloc/shipping_bloc.dart';
import 'package:e_commerce_app/features/shipping/ui/pages/shipping_page.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdressShippingPage extends StatelessWidget {
  AddAdressShippingPage({
    super.key,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final shippingBloc = ShippingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Add Address",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: BlocListener<ShippingBloc, ShippingState>(
        bloc: shippingBloc,
        listenWhen: (previous, current) => current is ShippingActionState,
        listener: (context, state) {
          if (state is ShippingNewAddressAddedSuccessfullyActionState) {
            log("Added Succ..");
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              ),
            );
            Future.delayed(
              const Duration(milliseconds: 700),
              () {
                Navigator.pop(context); // For popping the progress indicator
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShippingPage(),
                  ),
                );
              },
            );
          } else if (state is ShippingNewAddressInvalidTypeActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all the fields"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: false,
                  hintText: "Country",
                  controller: _countryController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: false,
                  hintText: "Name",
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: false,
                  hintText: "Street Address",
                  controller: _streetController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: false,
                  hintText: "City",
                  controller: _cityController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: false,
                  hintText: "State",
                  controller: _stateController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: false,
                  showNumberTypeKeyboard: true,
                  hintText: "Zip Code",
                  controller: _zipcodeController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AddressTextField(
                  showPhoneNumberTypeKeyboard: true,
                  showNumberTypeKeyboard: true,
                  hintText: "Phone Number",
                  controller: _phoneNumberController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  heading: "Add Address",
                  onTap: () {
                    if (_cityController.text.isEmpty ||
                        _countryController.text.isEmpty ||
                        _nameController.text.isEmpty ||
                        _phoneNumberController.text.isEmpty ||
                        _stateController.text.isEmpty ||
                        _streetController.text.isEmpty ||
                        _zipcodeController.text.isEmpty ||
                        _cityController.text.characters.length < 2 ||
                        _countryController.text.characters.length < 2 ||
                        _nameController.text.characters.length < 2 ||
                        _phoneNumberController.text.characters.length < 2 ||
                        _stateController.text.characters.length < 2 ||
                        _streetController.text.characters.length < 2 ||
                        _zipcodeController.text.characters.length < 2) {
                      shippingBloc.add(ShippingNewAddressInvalidTypeEvent());
                      return;
                    } else {
                      // shippingBloc.add(
                      //     ShippingNewAddressAddedSuccessfullyActionState());
                      shippingBloc.add(ShippingAddAddressEvent(
                        address: AddressModel(
                          name: _nameController.text,
                          phoneNumber: _phoneNumberController.text,
                          address:
                              "${_streetController.text}, ${_cityController.text}, ${_stateController.text}, ${_countryController.text}, ${_zipcodeController.text}",
                          isSelected: false,
                        ),
                      ));
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
