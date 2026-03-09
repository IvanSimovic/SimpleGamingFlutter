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
  String get search => 'Search';

  @override
  String get noResults => 'No results found';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get addGameTitle => 'Add Game';

  @override
  String get navReels => 'Reels';

  @override
  String get navAdd => 'Add';

  @override
  String get navFavourites => 'Favourites';

  @override
  String get noFavourites => 'No favourites yet';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get reelsEmpty => 'No more games to discover';
}
