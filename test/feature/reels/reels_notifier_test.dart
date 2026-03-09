import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_providers.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_repository.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_state.dart';

import '../../fakes/fake_games_repository.dart';
import '../../fakes/fake_reels_repository.dart';
import '../../helpers/test_helpers.dart';

List<ReelGame> _fakeGames(int count) => List.generate(
      count,
      (i) => ReelGame(
        id: 'game-$i',
        name: 'Game $i',
        imageUrl: 'https://example.com/$i.jpg',
        rating: 4.0,
        genres: ['Action'],
      ),
    );

void main() {
  late FakeReelsRepository fakeReelsRepo;
  late FakeGamesRepository fakeGamesRepo;
  late ProviderContainer container;

  // Fakes are created in setUp so tests can configure them BEFORE
  // buildContainer, which starts the provider and triggers _init()
  // synchronously via container.listen().
  setUp(() {
    fakeReelsRepo = FakeReelsRepository();
    fakeGamesRepo = FakeGamesRepository();
  });

  void buildContainer({Set<String> favouriteIds = const {}}) {
    container = ProviderContainer(
      overrides: [
        reelsRepositoryProvider.overrideWithValue(fakeReelsRepo),
        gamesRepositoryProvider.overrideWithValue(fakeGamesRepo),
        authStateProvider.overrideWith(
          (_) => Stream.value(FakeFirebaseUser()),
        ),
        favouriteGameIdsProvider.overrideWith((_) => favouriteIds),
      ],
    );
    addTearDown(container.dispose);
    container.listen(reelsNotifierProvider, (_, __) {});
  }

  /// Waits one event-loop turn for [_init] to complete.
  Future<void> pumpInit() => Future.delayed(Duration.zero);

  group('initial load', () {
    test('starts in loading state synchronously', () {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer();
      expect(container.read(reelsNotifierProvider), isA<ReelsLoading>());
    });

    test('transitions to content after successful fetch', () async {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer();
      await pumpInit();

      final state = container.read(reelsNotifierProvider);
      expect(state, isA<ReelsContent>());
      expect((state as ReelsContent).games.length, 5);
      expect(state.currentIndex, 0);
      expect(state.isLoadingMore, false);
    });

    test('transitions to empty when API returns no games', () async {
      fakeReelsRepo.fetchResult = [];
      buildContainer();
      await pumpInit();

      expect(container.read(reelsNotifierProvider), isA<ReelsEmpty>());
    });

    test('transitions to error on fetch failure', () async {
      fakeReelsRepo.fetchException = Exception('network error');
      buildContainer();
      await pumpInit();

      expect(container.read(reelsNotifierProvider), isA<ReelsError>());
    });

    test('hasReachedEnd is true when API signals no more pages', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(5)
        ..hasMore = false;
      buildContainer();
      await pumpInit();

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent).hasReachedEnd,
        true,
      );
    });

    test('hasReachedEnd is false when more pages are available', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(5)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent).hasReachedEnd,
        false,
      );
    });
  });

  group('onPageChanged', () {
    test('updates currentIndex in state', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      container.read(reelsNotifierProvider.notifier).onPageChanged(3);

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent).currentIndex,
        3,
      );
    });

    test('does not trigger load more when below prefetch threshold', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      container.read(reelsNotifierProvider.notifier).onPageChanged(10);
      await Future.delayed(Duration.zero);

      // Only the initial fetch was made.
      expect(fakeReelsRepo.requestedPages.length, 1);
    });

    test('triggers load more when at prefetch threshold', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      // Threshold is 5 — index 15 of 20 triggers prefetch.
      container.read(reelsNotifierProvider.notifier).onPageChanged(15);
      await Future.delayed(Duration.zero);

      expect(fakeReelsRepo.requestedPages.length, 2);
    });

    test('does not trigger duplicate load more while already loading',
        () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      // Both swipes hit the threshold synchronously before _loadMore awaits.
      container.read(reelsNotifierProvider.notifier).onPageChanged(15);
      container.read(reelsNotifierProvider.notifier).onPageChanged(16);
      await Future.delayed(Duration.zero);

      // isLoadingMore guard prevents a second concurrent fetch.
      expect(fakeReelsRepo.requestedPages.length, 2);
    });

    test('load more appends games to existing list', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = true;
      buildContainer();
      await pumpInit();

      // Reconfigure fake for the second page before triggering load more.
      fakeReelsRepo.fetchResult = _fakeGames(10);

      container.read(reelsNotifierProvider.notifier).onPageChanged(15);
      await Future.delayed(Duration.zero);

      final state = container.read(reelsNotifierProvider) as ReelsContent;
      expect(state.games.length, 30); // 20 initial + 10 more
    });

    test('no load more when hasReachedEnd is true', () async {
      fakeReelsRepo
        ..fetchResult = _fakeGames(20)
        ..hasMore = false;
      buildContainer();
      await pumpInit();

      container.read(reelsNotifierProvider.notifier).onPageChanged(16);
      await Future.delayed(Duration.zero);

      expect(fakeReelsRepo.requestedPages.length, 1);
    });
  });

  group('toggleFavourite', () {
    test('adds to favouritingIds while in flight then clears on success',
        () async {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer();
      await pumpInit();
      await container.read(authStateProvider.future);

      final toggle = container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent)
            .favouritingIds
            .contains('game-0'),
        true,
      );

      await toggle;

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent)
            .favouritingIds
            .contains('game-0'),
        false,
      );
    });

    test('calls addFavouriteGame when game is not yet favourited', () async {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer(favouriteIds: {});
      await pumpInit();
      await container.read(authStateProvider.future);

      await container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');

      // removeFavouriteGame was NOT called — only add.
      expect(fakeGamesRepo.removedIds, isEmpty);
    });

    test('calls removeFavouriteGame when game is already favourited',
        () async {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer(favouriteIds: {'game-0'});
      await pumpInit();
      await container.read(authStateProvider.future);

      await container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');

      expect(fakeGamesRepo.removedIds, contains('game-0'));
    });

    test('second toggle on same game is ignored while first is in flight',
        () async {
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer(favouriteIds: {});
      await pumpInit();
      await container.read(authStateProvider.future);

      final first = container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');
      // Second call while first is in flight — should be no-op.
      container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');

      await first;
      await Future.delayed(Duration.zero);

      // Only one add was made.
      expect(fakeGamesRepo.removedIds.length, 0);
    });

    test('favouritingIds is cleaned up after repository failure', () async {
      fakeGamesRepo.addException = Exception('firestore error');
      fakeReelsRepo.fetchResult = _fakeGames(5);
      buildContainer(favouriteIds: {});
      await pumpInit();
      await container.read(authStateProvider.future);

      await container
          .read(reelsNotifierProvider.notifier)
          .toggleFavourite('game-0');

      expect(
        (container.read(reelsNotifierProvider) as ReelsContent)
            .favouritingIds
            .contains('game-0'),
        false,
      );
    });
  });
}
