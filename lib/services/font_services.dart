import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class FontServices {
  static const String _fontSizeKey = 'font_size_scale';
  static const String _fontFamilyKey = 'font_family';
  static final _storage = GetStorage();
  static const Map<String, String> availableFonts = {
    'Poppins': 'Poppins',
    'Roboto': 'roboto',
    'Lato': 'lato',
    'Montserrat': 'montserrat',
    'Open Sans': 'openSans',
  };
  static const Map<String, double> fontSizesScale = {
    'small': 0.8,
    'medium': 1.0,
    'large': 1.2,
    'xlarge': 1.5,
  };
  static double get currentFontScale =>
      _storage.read(_fontSizeKey) ??
      fontSizesScale["medium"]!; //this one is medium
  static String get currentFontFamily =>
      _storage.read(_fontFamilyKey) ?? availableFonts['Poppins']!;
  static Future<void> setFontScale(double scale) async {
    await _storage.write(_fontSizeKey, scale);
  }

  static Future<void> setFontFamily(String fontFamily) async {
    await _storage.write(_fontFamilyKey, fontFamily);
  }

  static TextTheme getCustomTextTheme(
    TextTheme baseTheme,
    double fontScale,
    String fontfamily,
  ) {
    TextTheme getFontTheme() {
      switch (fontfamily) {
        case 'roboto':
          return GoogleFonts.robotoTextTheme(baseTheme);
        case 'openSans':
          return GoogleFonts.openSansTextTheme(baseTheme);
        case 'montserrat':
          return GoogleFonts.montserratTextTheme(baseTheme);
        case 'lato':
          return GoogleFonts.latoTextTheme(baseTheme);
        default:
          return GoogleFonts.poppinsTextTheme(baseTheme);
      }
    }

    return getFontTheme().copyWith(
      displayLarge: getFontTheme().displayLarge?.copyWith(
            fontSize: (baseTheme.displayLarge?.fontSize ?? 32) * fontScale,
          ),
      displayMedium: getFontTheme().displayMedium?.copyWith(
            fontSize: (baseTheme.displayMedium?.fontSize ?? 28) * fontScale,
          ),
      displaySmall: getFontTheme().displaySmall?.copyWith(
            fontSize: (baseTheme.displaySmall?.fontSize ?? 24) * fontScale,
          ),
      headlineMedium: getFontTheme().headlineMedium?.copyWith(
            fontSize: (baseTheme.headlineMedium?.fontSize ?? 20) * fontScale,
          ),
      titleLarge: getFontTheme().titleLarge?.copyWith(
            fontSize: (baseTheme.titleLarge?.fontSize ?? 18) * fontScale,
          ),
      bodyLarge: getFontTheme().bodyLarge?.copyWith(
            fontSize: (baseTheme.bodyLarge?.fontSize ?? 16) * fontScale,
          ),
      bodyMedium: getFontTheme().bodyMedium?.copyWith(
            fontSize: (baseTheme.bodyMedium?.fontSize ?? 14) * fontScale,
          ),
      labelLarge: getFontTheme().labelLarge?.copyWith(
            fontSize: (baseTheme.labelLarge?.fontSize ?? 14) * fontScale,
          ),
    );
  }
}
