import 'package:flutter/material.dart';

/// Brand tokens mirrored from Easy-Post Desktop (app/ui/theme.py) so the two
/// products feel like one.
class Brand {
  static const Color accent = Color(0xFF2B6CB0);
  static const Color accentHover = Color(0xFF2C5282);
  static const Color accentSoft = Color(0xFFE8F0FB);
  static const Color text = Color(0xFF1A202C);
  static const Color muted = Color(0xFF5A6472);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F7FA);
  static const Color border = Color(0xFFD9DEE5);

  static ThemeData theme() {
    final scheme = ColorScheme.fromSeed(seedColor: accent).copyWith(
      primary: accent,
      surface: surface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: border),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accent),
      ),
    );
  }
}
