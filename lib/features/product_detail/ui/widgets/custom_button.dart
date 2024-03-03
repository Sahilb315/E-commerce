import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String heading;
  final void Function() onTap;
  const CustomButton({
    super.key,
    required this.heading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.68),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            heading,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: "Poppins",
            ),
          ),
        ),
      ),
    );
  }
}
