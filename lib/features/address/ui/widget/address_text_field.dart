import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool showNumberTypeKeyboard;
  final bool showPhoneNumberTypeKeyboard;
  const AddressTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.showNumberTypeKeyboard,
      required this.showPhoneNumberTypeKeyboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: MyTextThemes.myTextTheme().titleSmall,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLength: showPhoneNumberTypeKeyboard ? 10 : null,
          keyboardType: showNumberTypeKeyboard
              ? showPhoneNumberTypeKeyboard
                  ? TextInputType.phone
                  : TextInputType.number
              : TextInputType.text,
          controller: controller,
          cursorColor: AppColors.lightBlue600,
          cursorRadius: const Radius.circular(8),
          decoration: InputDecoration(
            hintText: "Enter the $hintText",
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
