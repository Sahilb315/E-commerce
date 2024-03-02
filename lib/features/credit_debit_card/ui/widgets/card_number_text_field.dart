import 'dart:math';

import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CardNumberTextField extends StatelessWidget {
  const CardNumberTextField({
    super.key,
    required TextEditingController cardNumberController,
  }) : _cardNumberController = cardNumberController;

  final TextEditingController _cardNumberController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: TextField(
        controller: _cardNumberController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(14),
          TextInputFormatter.withFunction(
            (oldValue, newValue) {
              String left = oldValue.text.substring(
                  0,
                  min(oldValue.selection.start,
                      newValue.selection.end));
              String right =
                  oldValue.text.substring(oldValue.selection.end);
              String inserted = newValue.text
                  .substring(left.length, newValue.selection.end);
              String modLeft = left.replaceAll(RegExp(r'\D'), "");
              String modRight = right.replaceAll(RegExp(r'\D'), "");
              String modInserted =
                  inserted.replaceAll(RegExp(r'\D'), "");
              final regEx = RegExp(r'\d{1,4}');
              String processString = modLeft + modInserted + modRight;
              String updated = regEx
                  .allMatches(processString)
                  .map((e) => e.group(0))
                  .join(" ");
              int cursorPosition = regEx
                  .allMatches(modLeft + modInserted)
                  .map((e) => e.group(0))
                  .join(" ")
                  .length;
              return TextEditingValue(
                text: updated,
                selection:
                    TextSelection.collapsed(offset: cursorPosition),
              );
            },
          )
        ],
        keyboardType: TextInputType.number,
        cursorColor: AppColors.backgroundColor,
        decoration: InputDecoration(
          labelText: "Card Number",
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
