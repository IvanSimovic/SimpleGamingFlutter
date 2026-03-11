import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_state.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

class FavouriteGamesNotifier extends AutoDisposeNotifier<FavouriteGamesState> {
  @override
  FavouriteGamesState build() => const FavouriteGamesState.normal();

  void onLongPress(String gameId) {
    state = FavouriteGamesState.selecting(gameId: gameId);
  }

  void cancelSelection() => state = const FavouriteGamesState.normal();

  Future<void> delete() async {
    final current = state;
    if (current is! FavouriteGamesSelecting) return;
    final gameId = current.gameId;
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null) return;
    state = FavouriteGamesState.deleting(gameId: gameId);
    try {
      await ref
          .read(gamesRepositoryProvider)
          .removeFavouriteGame(userId, gameId);
      state = const FavouriteGamesState.normal();
    } catch (_) {
      state = FavouriteGamesState.selecting(gameId: gameId);
    }
  }
}
