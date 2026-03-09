import 'package:flutter/material.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.head1,
    required this.head2,
    required this.head3,
    required this.head4,
    required this.head5,
    required this.body1,
    required this.body2,
    required this.body3,
    required this.body4,
    required this.body5,
    required this.body6,
    required this.body7,
  });

  final TextStyle head1;
  final TextStyle head2;
  final TextStyle head3;
  final TextStyle head4;
  final TextStyle head5;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle body3;
  final TextStyle body4;
  final TextStyle body5;
  final TextStyle body6;
  final TextStyle body7;

  static const standard = AppTypography(
    head1: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, height: 1.2),
    head2: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, height: 1.25),
    head3: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, height: 1.33),
    head4: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, height: 1.4),
    head5: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, height: 1.33),
    body1: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, height: 1.5),
    body2: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, height: 1.43),
    body3: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, height: 1.33),
    body4: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, height: 1.5),
    body5: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, height: 1.43),
    body6: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, height: 1.43),
    body7: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, height: 1.4),
  );

  @override
  AppTypography copyWith({
    TextStyle? head1,
    TextStyle? head2,
    TextStyle? head3,
    TextStyle? head4,
    TextStyle? head5,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? body3,
    TextStyle? body4,
    TextStyle? body5,
    TextStyle? body6,
    TextStyle? body7,
  }) =>
      AppTypography(
        head1: head1 ?? this.head1,
        head2: head2 ?? this.head2,
        head3: head3 ?? this.head3,
        head4: head4 ?? this.head4,
        head5: head5 ?? this.head5,
        body1: body1 ?? this.body1,
        body2: body2 ?? this.body2,
        body3: body3 ?? this.body3,
        body4: body4 ?? this.body4,
        body5: body5 ?? this.body5,
        body6: body6 ?? this.body6,
        body7: body7 ?? this.body7,
      );

  @override
  AppTypography lerp(AppTypography? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      head1: TextStyle.lerp(head1, other.head1, t)!,
      head2: TextStyle.lerp(head2, other.head2, t)!,
      head3: TextStyle.lerp(head3, other.head3, t)!,
      head4: TextStyle.lerp(head4, other.head4, t)!,
      head5: TextStyle.lerp(head5, other.head5, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      body3: TextStyle.lerp(body3, other.body3, t)!,
      body4: TextStyle.lerp(body4, other.body4, t)!,
      body5: TextStyle.lerp(body5, other.body5, t)!,
      body6: TextStyle.lerp(body6, other.body6, t)!,
      body7: TextStyle.lerp(body7, other.body7, t)!,
    );
  }
}
