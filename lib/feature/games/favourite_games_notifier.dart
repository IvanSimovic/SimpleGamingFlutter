import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_state.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

class FavouriteGamesNotifier extends AutoDisposeNotifier<FavouriteGamesState> {
  @override
  FavouriteGamesState build() => const FavouriteGamesState.normal();

  void onLongPress(String gameId) {
    state = FavouriteGamesState.selecting(selectedIds: {gameId});
  }

  void onTap(String gameId) {
    final current = state;
    if (current is! FavouriteGamesSelecting) return;
    final updated = Set<String>.from(current.selectedIds);
    if (updated.contains(gameId)) {
      updated.remove(gameId);
    } else {
      updated.add(gameId);
    }
    state = updated.isEmpty
        ? const FavouriteGamesState.normal()
        : FavouriteGamesState.selecting(selectedIds: updated);
  }

  void cancelSelection() => state = const FavouriteGamesState.normal();

  Future<void> deleteSelected() async {
    final current = state;
    if (current is! FavouriteGamesSelecting) return;
    final selectedIds = Set<String>.from(current.selectedIds);
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null) return;
    state = const FavouriteGamesState.deleting();
    try {
      await Future.wait(
        selectedIds.map(
          (id) =>
              ref.read(gamesRepositoryProvider).removeFavouriteGame(userId, id),
        ),
      );
      state = const FavouriteGamesState.normal();
    } catch (_) {
      state = FavouriteGamesState.selecting(selectedIds: selectedIds);
    }
  }
}
