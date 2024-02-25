import 'package:flutter/material.dart';

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  final TextInputType? inputType;
  final int maxNumbers;
  const PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.inputType,
    required this.maxNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.blue,
      keyboardType: inputType,
      maxLength: 10,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
