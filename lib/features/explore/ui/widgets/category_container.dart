import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String heading;
  final String assetImagePath;
  final void Function()? onTap;
  const CategoryContainer({
    super.key,
    required this.heading,
    required this.assetImagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  assetImagePath,
                ).image,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(
              heading,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: AppColors.blueGray300,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
