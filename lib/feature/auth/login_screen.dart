import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/core/components/app_button.dart';
import 'package:simple_gaming_flutter/core/components/app_text_field.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/core/theme/app_spacing.dart';
import 'package:simple_gaming_flutter/core/theme/app_theme.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  var _email = '';
  var _password = '';

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _signIn() {
    ref
        .read(loginNotifierProvider.notifier)
        .signIn(
          email: _email,
          password: _password,
          emailRequiredMessage: context.l10n.loginEmailRequired,
          passwordRequiredMessage: context.l10n.loginPasswordRequired,
        );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField(
              value: _email,
              onChanged: (v) => setState(() => _email = v),
              label: context.l10n.email,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSubmitted: _passwordFocus.requestFocus,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              value: _password,
              onChanged: (v) => setState(() => _password = v),
              label: context.l10n.password,
              focusNode: _passwordFocus,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: _signIn,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: context.l10n.loginSignIn,
              onPressed: _signIn,
              isLoading: loginState.isLoading,
              enabled: !loginState.isLoading,
            ),
            if (loginState.hasError) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                loginState.error.toString(),
                style: context.typo.body2.copyWith(color: context.colors.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
