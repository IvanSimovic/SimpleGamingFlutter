import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_state.dart';

class ReelsNotifier extends AutoDisposeNotifier<ReelsState> {
  static const _prefetchThreshold = 5;

  // Shared cancellation flag — set once in build() via ref.onDispose.
  // All async methods check this before touching state after an await.
  bool _cancelled = false;
  int _nextPage = 1;

  @override
  ReelsState build() {
    ref.onDispose(() => _cancelled = true);
    _init();
    return const ReelsState.loading();
  }

  Future<void> _init() async {
    try {
      final result = await ref
          .read(reelsRepositoryProvider)
          .fetchGames(page: _nextPage);
      if (_cancelled) return;
      _nextPage++;
      if (result.games.isEmpty) {
        state = const ReelsState.empty();
        return;
      }
      state = ReelsState.content(
        games: result.games,
        currentIndex: 0,
        isLoadingMore: false,
        hasReachedEnd: !result.hasMore,
        favouritingIds: {},
      );
    } catch (_) {
      if (_cancelled) return;
      state = const ReelsState.error();
    }
  }

  void onPageChanged(int index) {
    final current = state;
    if (current is! ReelsContent) return;
    final updated = current.copyWith(currentIndex: index);
    state = updated;
    _maybeLoadMore(updated);
  }

  void _maybeLoadMore(ReelsContent current) {
    if (current.isLoadingMore) return;
    if (current.hasReachedEnd) return;
    if (current.currentIndex < current.games.length - _prefetchThreshold) {
      return;
    }
    _loadMore();
  }

  Future<void> _loadMore() async {
    final current = state;
    if (current is! ReelsContent) return;
    // Set isLoadingMore synchronously before the first await so the guard
    // in _maybeLoadMore sees it on the next onPageChanged call.
    state = current.copyWith(isLoadingMore: true);
    try {
      final result = await ref
          .read(reelsRepositoryProvider)
          .fetchGames(page: _nextPage);
      if (_cancelled) return;
      _nextPage++;
      final currentAfterFetch = state;
      if (currentAfterFetch is! ReelsContent) return;
      state = currentAfterFetch.copyWith(
        games: [...currentAfterFetch.games, ...result.games],
        isLoadingMore: false,
        hasReachedEnd: !result.hasMore,
      );
    } catch (_) {
      if (_cancelled) return;
      final currentAfterError = state;
      if (currentAfterError is! ReelsContent) return;
      // Revert loading flag so _maybeLoadMore can retry on next swipe.
      state = currentAfterError.copyWith(isLoadingMore: false);
    }
  }

  Future<void> toggleFavourite(String gameId) async {
    final current = state;
    if (current is! ReelsContent) return;
    // Prevent duplicate in-flight requests for the same game.
    if (current.favouritingIds.contains(gameId)) return;

    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null) return;

    final isFavourited = ref.read(favouriteGameIdsProvider).contains(gameId);

    state = current.copyWith(
      favouritingIds: {...current.favouritingIds, gameId},
    );

    try {
      if (isFavourited) {
        await ref
            .read(gamesRepositoryProvider)
            .removeFavouriteGame(userId, gameId);
      } else {
        final game = current.games.firstWhere((g) => g.id == gameId);
        await ref
            .read(gamesRepositoryProvider)
            .addFavouriteGame(
              userId,
              Game(id: game.id, name: game.name, imageUrl: game.imageUrl),
            );
      }
    } catch (_) {
      // Operation failed — favouritingIds cleaned up in finally.
    } finally {
      if (!_cancelled) {
        final currentAfterOp = state;
        if (currentAfterOp is ReelsContent) {
          state = currentAfterOp.copyWith(
            favouritingIds: Set.from(currentAfterOp.favouritingIds)
              ..remove(gameId),
          );
        }
      }
    }
  }
}
