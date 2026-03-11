# SimpleGaming — Flutter

A Flutter port of the SimpleGaming Android app. Discover games through a vertical swipe feed, save favourites, and browse your collection.

## Features

**Reels** — A TikTok-style vertical swipe feed powered by the RAWG API. Each card shows cover art, genres, Metacritic score, user rating, screenshots, playtime, and platforms. Screenshots open into a full-screen viewer. Favouriting is available inline.

**Favourites** — A grid of saved games synced to Firestore. Long-press a card to enter selection mode; tap Delete to remove. Back press during selection cancels — during deletion it blocks until the operation completes.

**Add Game** — Search the RAWG catalogue with a 500ms debounce. Tap a result to add it to Firestore and navigate back automatically.

## Architecture

**State** — Riverpod with `Notifier` / `AsyncNotifier`. Each screen has its own provider, marked `autoDispose` so state is scoped to the screen's lifetime. State is modelled with Freezed sealed classes — loading, content, error, and empty states are explicit types, not booleans.

**Data** — Repositories are concrete classes injected via providers. The `GamesRepository` handles both the RAWG search (Dio) and Firestore favourites. The `ReelsRepository` handles RAWG game list and detail fetches. API models are private to the repository file — domain models cross the boundary clean.

**Navigation** — GoRouter with a `StatefulShellRoute` for the two-tab bottom nav. Each tab maintains its own back stack. The router is a stable Riverpod `Provider`, created once per app lifetime. Auth redirect is driven by a `refreshListenable` that bridges the Firestore auth stream into GoRouter's listener mechanism.

**Design system** — `AppColors` (semantic tokens backed by raw values), `AppTypography`, `AppSpacing`. All colours reference the token set — no hardcoded hex values in screens. Light and dark themes are both defined; mode follows the system setting.

**Localisation** — All user-facing strings are in `lib/l10n/app_en.arb`. The generated `AppLocalizations` class is accessed via `context.l10n` extension.

## Project structure

```
lib/
├── main.dart
├── core/
│   ├── components/        # AppButton, AppTextField
│   ├── l10n/              # context.l10n extension
│   ├── navigation/        # GoRouter config, routerProvider
│   ├── network/           # Dio provider, RAWG base URL + API key interceptor
│   └── theme/             # AppColors, AppTypography, AppSpacing, AppTheme
├── feature/
│   ├── auth/              # AuthRepository, LoginNotifier, LoginScreen
│   ├── games/             # GamesRepository, AddGame + FavouriteGames notifiers and screens
│   └── reels/             # ReelsRepository, ReelsNotifier, ReelsScreen
└── l10n/                  # .arb source files, generated localizations
```

## Running the project

**Prerequisites**

- Flutter SDK `^3.9.2`
- A Firebase project with Authentication (email/password) and Firestore enabled
- A [RAWG API key](https://rawg.io/apidocs)

**Setup**

1. Place your `google-services.json` in `android/app/`.
2. Run the app with your RAWG key injected at build time:

```sh
flutter run --dart-define=RAWG_API_KEY=your_key_here
```

The key is read at runtime via `String.fromEnvironment('RAWG_API_KEY')` and added to every RAWG request by a Dio interceptor. It is never committed to source control.

> The project currently has a hardcoded fallback key for development convenience. Remove it before any public release.

**Code generation**

Freezed models and Riverpod providers use code generation. After modifying any annotated class, run:

```sh
dart run build_runner build --delete-conflicting-outputs
```

**Localisation**

After modifying `lib/l10n/app_en.arb`, regenerate the localizations:

```sh
flutter gen-l10n
```

**Analysis**

```sh
flutter analyze
dart format .
```

Both must be clean before committing.
