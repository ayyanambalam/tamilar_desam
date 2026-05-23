import 'package:flutter/material.dart';

class AppTheme {
  static const yellow = Color(0xFFFFD600);
  static const pink = Color(0xFFE91E63);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: yellow,
      brightness: Brightness.light,
      primary: yellow,
      secondary: pink,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.white.withOpacity(0.86),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
