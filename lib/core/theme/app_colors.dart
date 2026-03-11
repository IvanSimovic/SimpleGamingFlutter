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

// Media overlay tokens — theme-invariant, used on dark image/video surfaces
// These are fixed values because they're layered on top of imagery, not app surfaces
const _mediaBackground = Color(0xFF000000);
const _mediaViewerBackground = Color(0xDD000000); // 87% — Colors.black87
const _overlayActionButton = Color(
  0x59000000,
); // 35% — floating button on media
const _overlayCard = Color(
  0x99000000,
); // 60% — cards/buttons overlaid on content
const _onMedia = Color(0xFFFFFFFF); // primary text/icons on dark media
const _onMediaMuted = Color(0xD9FFFFFF); // 85% — secondary text on dark media
const _onMediaSubtle = Color(0xBFFFFFFF); // 75% — tertiary text on dark media
const _onMediaChip = Color(0x2EFFFFFF); // 18% — chip background on dark media

// Media shimmer tokens — fixed dark values regardless of system theme,
// because the shimmer always appears on a dark media surface (Reels)
const _mediaShimmerBase = Color(0xFF2D2F31);
const _mediaShimmerHighlight = Color(0xFF444748);

// Score tier tokens — fixed colors following the Metacritic convention
const _scoreGood = Color(0xFF4CAF50);
const _scoreMixed = Color(0xFFFFC107);
const _scoreBad = Color(0xFFF44336);

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

  // Theme-invariant — media overlays and score tiers don't change with light/dark
  static const mediaBackground = _mediaBackground;
  static const mediaViewerBackground = _mediaViewerBackground;
  static const overlayActionButton = _overlayActionButton;
  static const overlayCard = _overlayCard;
  static const onMedia = _onMedia;
  static const onMediaMuted = _onMediaMuted;
  static const onMediaSubtle = _onMediaSubtle;
  static const onMediaChip = _onMediaChip;
  static const mediaShimmerBase = _mediaShimmerBase;
  static const mediaShimmerHighlight = _mediaShimmerHighlight;
  static const scoreGood = _scoreGood;
  static const scoreMixed = _scoreMixed;
  static const scoreBad = _scoreBad;

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
