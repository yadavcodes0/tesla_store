import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF090B10);
  static const Color panel = Color(0xFF11151D);
  static const Color panelMuted = Color(0xFF171C26);
  static const Color textPrimary = Color(0xFFF5F7FB);
  static const Color textMuted = Color(0xFFB0B8C9);
  static const Color success = Color(0xFF69D2A4);
  static const Color warning = Color(0xFFFF7A59);

  static ThemeData theme() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: base.colorScheme.copyWith(
        surface: panel,
        primary: Colors.white,
        secondary: warning,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panelMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        hintStyle: const TextStyle(color: textMuted),
      ),
    );
  }
}
