
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CreditCardAddingFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CreditCardAddingFormTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.backgroundColor,
        decoration: InputDecoration(
          labelText: hintText,
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
    );
  }
}
