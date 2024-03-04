import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool displayPrefixImage;
  const SignInButton(
      {super.key,
      this.onTap,
      required this.text,
      required this.displayPrefixImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: displayPrefixImage
              ? Colors.white
              : AppColors.backgroundColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(6),
          border: displayPrefixImage
              ? Border.all(color: Colors.grey.shade300)
              : Border.all(color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: displayPrefixImage
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        // alignment: Alignment.centerLeft,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/google-icon.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   text,
                    //   textAlign: TextAlign.center,
                    //   style: displayPrefixImage
                    //       ? const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //           color: Colors.grey,
                    //         )
                    //       : const TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    // ),
                    const SizedBox.shrink(),
                    const SizedBox.shrink()
                  ],
                )
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: displayPrefixImage
                      ? const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        )
                      : const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                ),
        ),
      ),
    );
  }
}
