// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get loginSignIn => 'Sign In';

  @override
  String get loginEmailRequired => 'Email is required';

  @override
  String get loginPasswordRequired => 'Password is required';

  @override
  String get loginSignInFailed => 'Sign in failed';

  @override
  String get navReels => 'Reels';

  @override
  String get navAdd => 'Add';

  @override
  String get navFavourites => 'Favourites';
}
