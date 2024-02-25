// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

// class AppColors {
//   static Color lightB = const Color(0x3d40bffff);
// }

class AppColors {
  static Color backgroundColor = Color.fromRGBO(3, 155, 229, 1).withOpacity(1);
  // Amber
  static Color get amber500 => const Color(0XFFFFC107);

  // Blue
  static Color get blue50 => const Color(0XFFEAEFFF);
  static Color get blueA200 => const Color(0XFF4091FF);

  // BlueGray
  static Color get blueGray300 => const Color(0XFF9098B1);

  // Gray
  static Color get gray400 => const Color(0XFFC4C4C4);

  // Indigo
  static Color get indigoA200 => const Color(0XFF5B61F4);

  // LightBlue
  static Color get lightBlue600 => const Color(0XFF039BE5);

  // Pink
  static Color get pink300 => const Color(0XFFFB7181);

  // Yellow
  static Color get yellow700 => const Color(0XFFFFC732);
}

class MyColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0X3D40BFFF),
    secondaryContainer: Color(0XFF53D1B6),

    // On colors(text colors)
    onPrimary: Color(0X87223263),
    onPrimaryContainer: Color(0X87FFFFFF),
  );
}

class MyTextThemes {
  static TextTheme myTextTheme() => TextTheme(
        bodySmall: TextStyle(
          color: AppColors.blueGray300,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: MyColorSchemes.primaryColorScheme.onPrimaryContainer.withOpacity(0.7),
          fontSize: 24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: MyColorSchemes.primaryColorScheme.onPrimary.withOpacity(1),
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: AppColors.pink300,
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: MyColorSchemes.primaryColorScheme.primary.withOpacity(1),
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: MyColorSchemes.primaryColorScheme.onPrimary.withOpacity(1),
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: MyColorSchemes.primaryColorScheme.onPrimary.withOpacity(1),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      );
}
