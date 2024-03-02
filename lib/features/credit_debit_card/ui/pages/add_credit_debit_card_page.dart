// ignore_for_file: must_be_immutable

import 'package:e_commerce_app/features/credit_debit_card/bloc/credit_debit_card_bloc.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/ui/pages/credit_debit_page.dart';
import 'package:e_commerce_app/features/credit_debit_card/ui/widgets/card_form_text_field.dart';
import 'package:e_commerce_app/features/credit_debit_card/ui/widgets/card_number_text_field.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCreditDebitCardPage extends StatelessWidget {
  AddCreditDebitCardPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController = TextEditingController();
  final TextEditingController _bankNameCodeController = TextEditingController();
  final cardBloc = CreditDebitCardBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Card",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              CustomButton(
                heading: "Add Card",
                onTap: () {
                  if (_cardNumberController.text.isNotEmpty ||
                      _expiryDateController.text.isNotEmpty ||
                      _cvvCodeController.text.isNotEmpty ||
                      _cardHolderNameController.text.isNotEmpty ||
                      _bankNameCodeController.text.isNotEmpty) {
                    // Add card
                    cardBloc.add(
                      CreditDebitAddNewCardEvent(
                        cardModel: CreditDebitCardModel(
                          cardNumber: _cardNumberController.text,
                          cardHolderName: _cardHolderNameController.text,
                          expiryDate: _expiryDateController.text,
                          cvvCode: _cvvCodeController.text,
                          bankName: _bankNameCodeController.text,
                          colorIndex: 0,
                          isSelected: false,
                        ),
                      ),
                    );
                  } else {
                    // Fill all fields
                    cardBloc.add(CreditDebitCardEmptyFieldEvent());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<CreditDebitCardBloc, CreditDebitCardState>(
        bloc: cardBloc,
        listenWhen: (previous, current) =>
            current is CreditDebitCardActionState,
        listener: (context, state) {
          if (state is CreditDebitCardAddedSuccessfullyActionState) {
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
                    builder: (context) => const CreditDebitPage(),
                  ),
                );
              },
            );
          } else if (state is CreditDebitCardEmptyFieldActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all fields"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            //?           Card Number Field
            CardNumberTextField(cardNumberController: _cardNumberController),
            Row(
              children: [
                //?           Expiry Date Field
                CardTextFieldWithFormatters(
                  controller: _expiryDateController,
                  maxLength: 5,
                  labelText: "Expiry Date",
                  hintText: "04/28",
                ),
                //?           CVV Field
                CardTextFieldWithFormatters(
                  controller: _cvvCodeController,
                  maxLength: 4,
                  labelText: "CVV Code",
                ),
              ],
            ),
            //?              Card Holder Field
            CreditCardAddingFormTextField(
              controller: _cardHolderNameController,
              hintText: "Card Holder Name",
            ),
            //?              Bank Name Field
            CreditCardAddingFormTextField(
              controller: _bankNameCodeController,
              hintText: "Bank Name",
            ),
          ],
        ),
      ),
    );
  }
}

class CardTextFieldWithFormatters extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final String labelText;
  final String? hintText;
  const CardTextFieldWithFormatters({
    super.key,
    required this.controller,
    required this.maxLength,
    required this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16,
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
          ],
          cursorColor: AppColors.backgroundColor,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
