import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Route paths
abstract final class AppRoutes {
  static const reels = '/reels';
  static const addGame = '/add';
  static const favourites = '/favourites';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.reels,
  routes: [
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.reels,
          builder: (_, __) => const _PlaceholderScreen(label: 'Reels'),
        ),
        GoRoute(
          path: AppRoutes.addGame,
          builder: (_, __) => const _PlaceholderScreen(label: 'Add Game'),
        ),
        GoRoute(
          path: AppRoutes.favourites,
          builder: (_, __) => const _PlaceholderScreen(label: 'Favourites'),
        ),
      ],
    ),
  ],
);

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexForLocation(location),
        onDestinationSelected: (index) =>
            context.go(_locationForIndex(index)),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.movie), label: 'Reels'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Add'),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }

  int _indexForLocation(String location) => switch (location) {
        AppRoutes.reels => 0,
        AppRoutes.addGame => 1,
        AppRoutes.favourites => 2,
        _ => 0,
      };

  String _locationForIndex(int index) => switch (index) {
        0 => AppRoutes.reels,
        1 => AppRoutes.addGame,
        2 => AppRoutes.favourites,
        _ => AppRoutes.reels,
      };
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: Text(label)),
      );
}
