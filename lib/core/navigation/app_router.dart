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

GoRouter buildRouter(WidgetRef ref) => GoRouter(
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
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        GoRoute(path: AppRoutes.reels, builder: (_, __) => const ReelsScreen()),
        GoRoute(
          path: AppRoutes.favourites,
          builder: (_, __) => const FavouriteGamesScreen(),
        ),
      ],
    ),
  ],
);

// Bridges Riverpod's authStateProvider stream into GoRouter's Listenable refresh mechanism
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final onFavourites = location == AppRoutes.favourites;

    return Scaffold(
      body: child,
      floatingActionButton: onFavourites
          ? FloatingActionButton(
              onPressed: () => context.push(AppRoutes.addGame),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexForLocation(location),
        onDestinationSelected: (index) => context.go(_locationForIndex(index)),
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

  int _indexForLocation(String location) => switch (location) {
    AppRoutes.reels => 0,
    AppRoutes.favourites => 1,
    _ => 0,
  };

  String _locationForIndex(int index) => switch (index) {
    0 => AppRoutes.reels,
    1 => AppRoutes.favourites,
    _ => AppRoutes.reels,
  };
}
