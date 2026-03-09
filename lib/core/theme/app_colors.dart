import 'package:flutter/material.dart';

// Raw color tokens — single source of truth
const _primaryLight = Color(0xFF0061A4);
const _primaryDark = Color(0xFF9ECAFF);

const _backgroundLight = Color(0xFFFDFCFF);
const _backgroundDark = Color(0xFF1A1C1E);

const _surfaceLight = Color(0xFFFDFCFF);
const _surfaceHighDark = Color(0xFF2D2F31);

const _onBackgroundLight = Color(0xFF1A1C1E);
const _onBackgroundDark = Color(0xFFE2E2E6);

const _textMutedLight = Color(0xFF74777F);
const _textMutedDark = Color(0xFF8E9199);

const _dividerLight = Color(0xFFC4C7C8);
const _dividerDark = Color(0xFF444748);

const _successLight = Color(0xFF2E7D32);
const _successDark = Color(0xFF81C784);

const _warningLight = Color(0xFFF9A825);
const _warningDark = Color(0xFFFFF176);

const _error = Color(0xFFBA1A1A);

// Semantic color set — meaning, not values
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandPrimary,
    required this.surfaceDeep,
    required this.surfaceHigh,
    required this.textMain,
    required this.textMuted,
    required this.divider,
    required this.success,
    required this.warning,
    required this.error,
  });

  final Color brandPrimary;
  final Color surfaceDeep;
  final Color surfaceHigh;
  final Color textMain;
  final Color textMuted;
  final Color divider;
  final Color success;
  final Color warning;
  final Color error;

  static const light = AppColors(
    brandPrimary: _primaryLight,
    surfaceDeep: _backgroundLight,
    surfaceHigh: _surfaceLight,
    textMain: _onBackgroundLight,
    textMuted: _textMutedLight,
    divider: _dividerLight,
    success: _successLight,
    warning: _warningLight,
    error: _error,
  );

  static const dark = AppColors(
    brandPrimary: _primaryDark,
    surfaceDeep: _backgroundDark,
    surfaceHigh: _surfaceHighDark,
    textMain: _onBackgroundDark,
    textMuted: _textMutedDark,
    divider: _dividerDark,
    success: _successDark,
    warning: _warningDark,
    error: _error,
  );

  @override
  AppColors copyWith({
    Color? brandPrimary,
    Color? surfaceDeep,
    Color? surfaceHigh,
    Color? textMain,
    Color? textMuted,
    Color? divider,
    Color? success,
    Color? warning,
    Color? error,
  }) => AppColors(
    brandPrimary: brandPrimary ?? this.brandPrimary,
    surfaceDeep: surfaceDeep ?? this.surfaceDeep,
    surfaceHigh: surfaceHigh ?? this.surfaceHigh,
    textMain: textMain ?? this.textMain,
    textMuted: textMuted ?? this.textMuted,
    divider: divider ?? this.divider,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    error: error ?? this.error,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      surfaceDeep: Color.lerp(surfaceDeep, other.surfaceDeep, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
