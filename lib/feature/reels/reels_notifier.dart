import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_state.dart';

class ReelsNotifier extends AutoDisposeNotifier<ReelsState> {
  static const _prefetchThreshold = 5;

  bool _cancelled = false;
  int _nextPage = 1;
  final Set<String> _detailLoadedIds = {};

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
      _loadDetail(0);
      _loadDetail(1);
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
    _loadDetail(index);
    _loadDetail(index + 1);
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

  Future<void> _loadDetail(int index) async {
    final current = state;
    if (current is! ReelsContent) return;
    final game = current.games.elementAtOrNull(index);
    if (game == null) return;
    if (_detailLoadedIds.contains(game.id)) return;
    _detailLoadedIds.add(game.id);
    try {
      final detail = await ref
          .read(reelsRepositoryProvider)
          .fetchGameDetail(game.id);
      if (_cancelled) return;
      final currentAfterFetch = state;
      if (currentAfterFetch is! ReelsContent) return;
      final gameIndex = currentAfterFetch.games.indexWhere(
        (g) => g.id == game.id,
      );
      if (gameIndex == -1) return;
      final updatedGames = List<ReelGame>.of(currentAfterFetch.games);
      updatedGames[gameIndex] = updatedGames[gameIndex].copyWith(
        description: detail.description,
        screenshots: detail.screenshots,
      );
      state = currentAfterFetch.copyWith(
        games: List.unmodifiable(updatedGames),
      );
    } catch (_) {
      // Detail unavailable — card shows without description/screenshots.
      // ID stays in _detailLoadedIds to avoid retrying on every swipe.
    }
  }

  Future<void> _loadMore() async {
    final current = state;
    if (current is! ReelsContent) return;
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
      state = currentAfterError.copyWith(isLoadingMore: false);
    }
  }

  Future<void> toggleFavourite(String gameId) async {
    final current = state;
    if (current is! ReelsContent) return;
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
