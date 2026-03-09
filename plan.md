# SimpleGaming Flutter Port — Plan

## How Flutter Maps to Android

| Android | Flutter | Notes |
|---|---|---|
| Koin modules | **Riverpod providers** | Providers are declared globally, scoped by ref — no explicit module registration. No Application class needed. |
| `BaseViewModel<S, A>` | **`Notifier<S>` / `AsyncNotifier<S>`** | Riverpod's Notifier holds state, exposes methods. No action objects — just methods that mutate state directly. Simpler but same isolation principle. |
| `sealed class UiState` | **Freezed `@freezed` union** | Freezed generates copyWith, equals, pattern matching. Equivalent to Kotlin data classes + sealed classes combined. |
| `Result<T>` | **`AsyncValue<T>`** | Built into Riverpod. Three states: loading/data/error. Notifiers already speak this type — don't wrap it in a custom Result on top. |
| Repository interface + impl | **Concrete repository class + provider override in tests** | No interface needed. Riverpod lets you override any provider in tests directly. Add an interface only if you genuinely have multiple implementations. |
| Jetpack Compose | **Flutter widgets** | Stateless = `StatelessWidget`. Everything is a widget. No `@Composable` annotation — just `build()` override. |
| `collectAsStateWithLifecycle()` | **`ref.watch(provider)`** | Riverpod handles lifecycle. Watching a provider in `build()` is equivalent to collecting a StateFlow. |
| Room | **Isar** (already in project) | Schema-driven, generated code, reactive queries. |
| Retrofit + OkHttp | **Dio** | Interceptors, base URL, logging — exact same concepts. No annotation-based service interface; define a data source class with Dio directly. |
| `@Serializable` data class | **`fromJson`/`toJson` via `json_serializable`** | Run `build_runner` to generate. Freezed handles this too with `@JsonSerializable`. |
| Type-safe Navigation | **GoRouter with typed routes** | `GoRoute` + `ShellRoute` for bottom nav. Type-safe via `go_router_builder` code gen. |
| `LaunchedEffect` | **`ref.listen`** | One-shot side effects (navigate after success, show snackbar) handled via `ref.listen` on a provider in the widget's `build()`. |
| `BottomNavigationBar` | **`NavigationBar` widget** | Same concept. GoRouter's `ShellRoute` maintains back stacks per tab. |
| Spotless | **`dart format`** | Built-in, opinionated, no configuration. Stricter than Spotless — one style, no debate. |
| Detekt (style + bugs) | **`flutter analyze`** | Built-in. Catches unused variables, missing awaits, type issues. Configured via `analysis_options.yaml`. |
| Detekt (complexity) | **`dart_code_metrics`** | Package added to `analysis_options.yaml`. Adds cyclomatic complexity, function length, parameter count thresholds. |
| Shimmer loading | **`shimmer` package** | Direct equivalent. |
| Lottie animations | **`lottie` package** | Same files, same API shape. |

### Key Flutter-Specific Things to Know
- **No ViewModel scoping per screen** — Riverpod providers are global by default. Use `ref.watch` inside widgets. Providers auto-dispose with `autoDispose` modifier.
- **`build_runner`** — code generation tool used by Freezed, Riverpod generator, json_serializable, go_router_builder. Run `dart run build_runner build` after touching annotated classes. Equivalent to kapt/ksp.
- **`pubspec.yaml`** is `build.gradle`. Dependencies declared there, `flutter pub get` fetches them.
- **No Activity/Fragment** — everything is widgets. `main.dart` → `runApp(ProviderScope(child: App()))`. `ProviderScope` is the equivalent of `startKoin {}`.
- **Widget tree IS the UI** — no XML layouts, no inflation. Compose analogy is close but widgets are immutable objects rebuilt on state change, not composable functions re-executed.

---

## Project Structure Target

Flat by default. No `data/domain/presentation` subdirectories unless a feature grows large enough to need them. Start with files, split into folders when the feature earns it.

```
lib/
├── main.dart                          # runApp + ProviderScope + Firebase init
├── core/
│   ├── theme/                         # AppTheme, colors, typography, spacing tokens
│   ├── navigation/                    # GoRouter config, route definitions
│   └── network/                       # Dio provider, interceptors
├── feature/
│   ├── auth/
│   │   ├── auth_repository.dart       # concrete class, Firebase Auth calls
│   │   ├── auth_providers.dart        # authStateProvider, loginNotifierProvider
│   │   └── login_screen.dart
│   ├── games/
│   │   ├── game_model.dart            # Freezed domain model
│   │   ├── games_repository.dart      # Dio search + Firestore favourites
│   │   ├── games_providers.dart       # gameSearchProvider, favouriteGameIdsProvider, etc.
│   │   ├── add_game_screen.dart
│   │   └── favourite_games_screen.dart
│   └── reels/
│       ├── reel_game_model.dart       # Freezed domain model
│       ├── reels_repository.dart      # Dio game detail + Firestore reel queue
│       ├── reels_providers.dart       # reelGameIdsProvider, reelsNotifierProvider
│       └── reels_screen.dart
```

---

## Packages

```yaml
# Code quality
dart_code_metrics: ^5.x

# State
flutter_riverpod: ^2.x
riverpod_annotation: ^2.x        # code-gen for providers

# Immutable models + sealed state
freezed: ^2.x
freezed_annotation: ^2.x
json_serializable: ^6.x

# Navigation
go_router: ^14.x

# Network
dio: ^5.x

# Firebase (already configured)
firebase_core:
firebase_auth:
cloud_firestore:
google_sign_in:

# Code gen runner (dev)
build_runner: ^2.x
riverpod_generator: ^2.x

# UI
shimmer: ^3.x
lottie: ^3.x
cached_network_image: ^3.x       # equivalent of Coil
```

---

## Phase Plan

### Phase 1 — Foundation
- `android/app/build.gradle` — change `applicationId` to `com.simovic.simplegaming`
- `android/app/src/main/AndroidManifest.xml` — change `android:label` to `"Gaming Flutter"`
- Copy `google-services.json` from `SimpleGaming/app/` to `SimpleGamingFlutter/android/app/`
- Delete tutorial code from `lib/` — remove `models/`, `services/`, `pages/`, `components/`. Keep `firebase_options.dart`.
- `pubspec.yaml` — replace current dependencies with the packages listed above, run `pub get`
- `analysis_options.yaml` — configure `flutter analyze` rules and wire up `dart_code_metrics` with complexity/length thresholds
- `main.dart` — rewrite: `ProviderScope` + Firebase init (references `firebase_options.dart`)
- `core/theme/` — `AppTheme`, semantic color tokens, typography scale, spacing constants
- `core/network/` — Dio provider with RAWG base URL + API key interceptor. Key supplied via `--dart-define=RAWG_API_KEY=xxx` at run/build time, read with `String.fromEnvironment('RAWG_API_KEY')`.
- `core/navigation/` — GoRouter with `ShellRoute` (bottom nav shell) + 3 tab routes

### Phase 2 — Auth
- `auth_repository.dart` — concrete class wrapping Firebase Auth
- `auth_providers.dart` — `authStateProvider` (`StreamProvider<User?>`), `loginNotifierProvider`
- `LoginNotifier` (`AsyncNotifier`) — signIn, signOut
- `LoginScreen` — uses design system components
- Auth-gating via GoRouter `redirect` watching `authStateProvider`

### Phase 3 — Games (Search + Add)
- `game_model.dart` — Freezed `Game` model with `@JsonSerializable`
- `games_repository.dart` — Dio search, Firestore favourites CRUD
- `games_providers.dart`:
  - `gamesRepositoryProvider`
  - `gameSearchProvider` — `AsyncNotifier`, debounced search
  - `favouriteGameIdsProvider` — `StreamProvider`, live Firestore feed
- `AddGameScreen` — 2-column grid, shimmer

### Phase 4 — Favourite Games
- `games_providers.dart` additions:
  - `favouriteGamesProvider` — `StreamProvider`, live list from Firestore
  - `favouriteGamesNotifierProvider` — delete operations
- `FavouriteGamesScreen` — 2-column grid, long-press select, delete overlay, shake animation

### Phase 5 — Reels
- `reel_game_model.dart` — Freezed `ReelGame` model
- `reels_repository.dart` — Dio game detail, Firestore reel queue
- `reels_providers.dart`:
  - `reelsRepositoryProvider`
  - `reelGameIdsProvider` — `StreamProvider`, live queue from Firestore
  - `reelsNotifierProvider` — prefetch threshold, loadingPages guard, favourite sync
- `ReelsScreen` — swipeable vertical card stack

---

## Implementation Rules

- **No business logic in widgets.** Widgets call Notifier methods, display state. Period.
- **Notifiers read from repositories, not from Dio or Firestore directly.**
- **All state is Freezed.** No mutable fields in state classes.
- **All errors surface via `AsyncValue.error`.** No silent catches.
- **Design system only.** No hardcoded colours, sizes, or font values in widgets.
- **`autoDispose` on screen-level providers.** Provider is alive while the screen is on the stack, gone when it's not.
- **Run `build_runner` after every model or provider annotation change.** Treat it like a compile step.
- **No repository interfaces by default.** Override the provider in tests. Add an interface only when a second implementation exists.
- **No UseCase classes by default.** Provider methods are the composition layer. Add a class only when a Notifier method becomes genuinely complex.
- **Start flat, split when it hurts.** Don't create `data/domain/presentation` subdirectories until the feature has enough files that the flat list becomes hard to navigate.
- **Tests use provider overrides, not mocks.** Override the repository provider with a fake in `ProviderScope`. Test behaviour, not implementation.
- **`dart format` before every commit.** Non-negotiable. `flutter analyze` must pass clean.
