import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_state.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

class AddGameNotifier extends AutoDisposeNotifier<AddGameState> {
  Timer? _debounceTimer;

  @override
  AddGameState build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    return const AddGameState.idle();
  }

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      state = const AddGameState.idle();
      return;
    }
    state = const AddGameState.loading();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () => _search(query.trim()),
    );
  }

  Future<void> _search(String query) async {
    try {
      final results = await ref
          .read(gamesRepositoryProvider)
          .searchGames(query);
      state = results.isEmpty
          ? const AddGameState.empty()
          : AddGameState.content(results);
    } catch (_) {
      state = const AddGameState.error();
    }
  }

  Future<void> addGame(Game game) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null) {
      state = const AddGameState.error();
      return;
    }
    state = const AddGameState.loading();
    try {
      await ref.read(gamesRepositoryProvider).addFavouriteGame(userId, game);
      state = const AddGameState.added();
    } catch (_) {
      state = const AddGameState.error();
    }
  }
}
