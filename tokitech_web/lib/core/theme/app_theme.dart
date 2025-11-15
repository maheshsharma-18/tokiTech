import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    const seed = Color(0xFF006778);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seed),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
        headlineMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE0E6ED)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: seed, width: 1.4),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true);
  }
}
