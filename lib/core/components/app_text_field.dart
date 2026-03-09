import 'package:flutter/material.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.onSubmitted,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String label;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) => TextField(
        controller: TextEditingController(text: value)
          ..selection =
              TextSelection.collapsed(offset: value.length),
        focusNode: focusNode,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
        style: context.typo.body1.copyWith(color: context.colors.textMain),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              context.typo.body2.copyWith(color: context.colors.textMuted),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: context.colors.brandPrimary, width: 2),
          ),
          filled: true,
          fillColor: context.colors.surfaceHigh,
        ),
      );
}
