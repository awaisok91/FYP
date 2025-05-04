import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.lightText,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.lightText,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
  );
}
