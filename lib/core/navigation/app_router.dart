import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_gaming_flutter/core/l10n/l10n_extension.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/auth/login_screen.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_screen.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_screen.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_screen.dart';

// Route paths
abstract final class AppRoutes {
  static const login = '/login';
  static const reels = '/reels';
  static const addGame = '/add';
  static const favourites = '/favourites';
}

// Stable provider — GoRouter is created once per ProviderScope lifetime.
// Recreating it inside App.build() would reset navigation state on any rebuild.
final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.reels,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isLoggedIn = authState.valueOrNull != null;
      final isOnLogin = state.matchedLocation == AppRoutes.login;

      if (!isLoggedIn && !isOnLogin) return AppRoutes.login;
      if (isLoggedIn && isOnLogin) return AppRoutes.reels;
      return null;
    },
    refreshListenable: _AuthStateListenable(ref),
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.addGame,
        builder: (context, __) =>
            AddGameScreen(onNavigateBack: () => context.pop()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reels,
                builder: (_, __) => const ReelsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favourites,
                builder: (_, __) => const FavouriteGamesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

// Bridges Riverpod's authStateProvider stream into GoRouter's Listenable refresh mechanism
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AsyncValue<User?>>(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final onFavourites = navigationShell.currentIndex == 1;

    return Scaffold(
      body: navigationShell,
      floatingActionButton: onFavourites
          ? FloatingActionButton(
              onPressed: () => context.push(AppRoutes.addGame),
              tooltip: context.l10n.fabAddGame,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.movie),
            label: context.l10n.navReels,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite),
            label: context.l10n.navFavourites,
          ),
        ],
      ),
    );
  }
}
