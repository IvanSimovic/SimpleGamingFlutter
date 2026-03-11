import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_state.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_providers.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

import '../../fakes/fake_games_repository.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late FakeGamesRepository fakeRepo;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = FakeGamesRepository();
    container = ProviderContainer(
      overrides: [
        gamesRepositoryProvider.overrideWithValue(fakeRepo),
        authStateProvider.overrideWith((_) => Stream.value(FakeFirebaseUser())),
      ],
    );
    addTearDown(container.dispose);
    // Keep the autoDispose provider alive for the duration of the test.
    container.listen(addGameNotifierProvider, (_, __) {});
  });

  group('onQueryChanged', () {
    test('empty query sets idle state immediately', () {
      container.read(addGameNotifierProvider.notifier).onQueryChanged('');
      expect(container.read(addGameNotifierProvider), isA<AddGameIdle>());
    });

    test('whitespace-only query sets idle state immediately', () {
      container.read(addGameNotifierProvider.notifier).onQueryChanged('   ');
      expect(container.read(addGameNotifierProvider), isA<AddGameIdle>());
    });

    test('non-empty query sets loading state immediately', () {
      container
          .read(addGameNotifierProvider.notifier)
          .onQueryChanged('minecraft');
      expect(container.read(addGameNotifierProvider), isA<AddGameLoading>());
    });

    test('search with results sets content state after debounce', () async {
      fakeRepo.searchResult = [
        const Game(id: '1', name: 'Minecraft', imageUrl: 'url'),
      ];
      container
          .read(addGameNotifierProvider.notifier)
          .onQueryChanged('minecraft');

      await Future.delayed(const Duration(milliseconds: 600));

      final state = container.read(addGameNotifierProvider);
      expect(state, isA<AddGameContent>());
      expect((state as AddGameContent).results.length, 1);
      expect(state.results.first.name, 'Minecraft');
    });

    test('search with no results sets empty state after debounce', () async {
      fakeRepo.searchResult = [];
      container
          .read(addGameNotifierProvider.notifier)
          .onQueryChanged('xyznotfound');

      await Future.delayed(const Duration(milliseconds: 600));

      expect(container.read(addGameNotifierProvider), isA<AddGameEmpty>());
    });

    test('search failure sets error state after debounce', () async {
      fakeRepo.searchException = Exception('network error');
      container
          .read(addGameNotifierProvider.notifier)
          .onQueryChanged('minecraft');

      await Future.delayed(const Duration(milliseconds: 600));

      expect(container.read(addGameNotifierProvider), isA<AddGameError>());
    });

    test('rapid queries debounce — only last query fires search', () async {
      // Fire three queries in quick succession. Only the last should trigger
      // the search because each new query cancels the previous timer.
      container.read(addGameNotifierProvider.notifier).onQueryChanged('m');
      container.read(addGameNotifierProvider.notifier).onQueryChanged('mi');
      container
          .read(addGameNotifierProvider.notifier)
          .onQueryChanged('minecraft');

      fakeRepo.searchResult = [
        const Game(id: '1', name: 'Minecraft', imageUrl: ''),
      ];

      await Future.delayed(const Duration(milliseconds: 600));

      // Only the last query's result appears in content state.
      expect(container.read(addGameNotifierProvider), isA<AddGameContent>());
    });
  });

  group('addGame', () {
    const game = Game(id: '1', name: 'Minecraft', imageUrl: 'url');

    test('sets added state on success', () async {
      await container.read(authStateProvider.future);
      await container.read(addGameNotifierProvider.notifier).addGame(game);
      expect(container.read(addGameNotifierProvider), isA<AddGameAdded>());
    });

    test('sets error state when repository throws', () async {
      fakeRepo.addException = Exception('firestore error');
      await container.read(authStateProvider.future);
      await container.read(addGameNotifierProvider.notifier).addGame(game);
      expect(container.read(addGameNotifierProvider), isA<AddGameError>());
    });

    test('sets error state when user is not authenticated', () async {
      // Override auth to return no user.
      final unauthContainer = ProviderContainer(
        overrides: [
          gamesRepositoryProvider.overrideWithValue(fakeRepo),
          authStateProvider.overrideWith((_) => Stream.value(null)),
        ],
      );
      addTearDown(unauthContainer.dispose);
      unauthContainer.listen(addGameNotifierProvider, (_, __) {});

      await unauthContainer.read(authStateProvider.future);
      await unauthContainer
          .read(addGameNotifierProvider.notifier)
          .addGame(game);

      expect(
        unauthContainer.read(addGameNotifierProvider),
        isA<AddGameError>(),
      );
    });
  });
}
