import 'package:flutter/material.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: context.colors.brandPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(text, style: context.typo.body6),
      );
}
