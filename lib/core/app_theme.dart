import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  final Color primaryAccentColor;
  final Color secondaryAccentColor;
  final Color primaryBackgroundColor;
  final Color primaryLayerColor;
  final Color primaryTextColor;
  final Color primaryPlaceHolderTextColor;

  AppColors({
    required this.primaryAccentColor,
    required this.secondaryAccentColor,
    required this.primaryBackgroundColor,
    required this.primaryLayerColor,
    required this.primaryTextColor,
    required this.primaryPlaceHolderTextColor,
  });
}

class AppTheme {
  static final colors = AppColors(
    primaryAccentColor: const Color(0xFF1463F5),
    secondaryAccentColor: const Color(0xFFE5EDFF),
    primaryBackgroundColor: const Color(0xFFF9F9F9),
    primaryLayerColor: const Color(0xFFF2F2F2),
    primaryTextColor: const Color(0xFF211814),
    primaryPlaceHolderTextColor: const Color(0xFFBFBFBF),
  );

  static ThemeData buildTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: colors.primaryBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.colors.primaryBackgroundColor,
      ),
      textTheme: Theme.of(context)
          .textTheme
          .merge(GoogleFonts.ralewayTextTheme())
          .apply(
            bodyColor: colors.primaryTextColor,
          ),
    );
  }
}
