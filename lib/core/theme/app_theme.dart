import 'package:flutter/material.dart';
import 'package:simple_gaming_flutter/core/theme/app_colors.dart';
import 'package:simple_gaming_flutter/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);
  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.brandPrimary,
      onPrimary: Colors.white,
      secondary: colors.brandPrimary,
      onSecondary: Colors.white,
      error: colors.error,
      onError: Colors.white,
      surface: colors.surfaceHigh,
      onSurface: colors.textMain,
    ),
    scaffoldBackgroundColor: colors.surfaceDeep,
    extensions: [colors, AppTypography.standard],
  );
}

// Convenient context accessors — equivalent of Android's AppTheme.color / AppTheme.typo
extension AppThemeX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppTypography get typo => Theme.of(this).extension<AppTypography>()!;
}
