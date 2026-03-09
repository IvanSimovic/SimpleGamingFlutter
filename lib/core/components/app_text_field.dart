import 'package:flutter/material.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';

class AppTextField extends StatefulWidget {
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync external value only when it differs from what the controller holds,
    // preserving cursor position when the user is actively typing.
    if (widget.value != _controller.text) {
      _controller.value = _controller.value.copyWith(text: widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    focusNode: widget.focusNode,
    onChanged: widget.onChanged,
    obscureText: widget.obscureText,
    keyboardType: widget.keyboardType,
    textInputAction: widget.textInputAction,
    onSubmitted: widget.onSubmitted != null
        ? (_) => widget.onSubmitted!()
        : null,
    style: context.typo.body1.copyWith(color: context.colors.textMain),
    decoration: InputDecoration(
      labelText: widget.label,
      labelStyle: context.typo.body2.copyWith(color: context.colors.textMuted),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colors.brandPrimary, width: 2),
      ),
      filled: true,
      fillColor: context.colors.surfaceHigh,
    ),
  );
}
