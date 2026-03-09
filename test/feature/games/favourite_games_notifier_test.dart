import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_state.dart';
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
        authStateProvider.overrideWith(
          (_) => Stream.value(FakeFirebaseUser()),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(favouriteGamesNotifierProvider, (_, __) {});
  });

  test('initial state is normal', () {
    expect(
      container.read(favouriteGamesNotifierProvider),
      isA<FavouriteGamesNormal>(),
    );
  });

  group('onLongPress', () {
    test('enters selecting state with the pressed game id', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');

      final state = container.read(favouriteGamesNotifierProvider);
      expect(state, isA<FavouriteGamesSelecting>());
      expect((state as FavouriteGamesSelecting).selectedIds, {'game-1'});
    });
  });

  group('onTap', () {
    test('adding a second game extends the selection', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-2');

      final state = container.read(favouriteGamesNotifierProvider);
      expect((state as FavouriteGamesSelecting).selectedIds,
          {'game-1', 'game-2'});
    });

    test('deselecting the only selected game returns to normal', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-1');

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });

    test('deselecting one of multiple selected games keeps selecting state',
        () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-2');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-1');

      final state = container.read(favouriteGamesNotifierProvider);
      expect(state, isA<FavouriteGamesSelecting>());
      expect((state as FavouriteGamesSelecting).selectedIds, {'game-2'});
    });

    test('tap is ignored when not in selecting state', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-1');

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });
  });

  group('cancelSelection', () {
    test('returns to normal from selecting state', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .cancelSelection();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });
  });

  group('deleteSelected', () {
    test('successful delete returns to normal state', () async {
      await container.read(authStateProvider.future);
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');

      await container
          .read(favouriteGamesNotifierProvider.notifier)
          .deleteSelected();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });

    test('successful delete calls removeFavouriteGame for each selected id',
        () async {
      await container.read(authStateProvider.future);
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onTap('game-2');

      await container
          .read(favouriteGamesNotifierProvider.notifier)
          .deleteSelected();

      expect(fakeRepo.removedIds, containsAll(['game-1', 'game-2']));
    });

    test('repository failure restores selecting state with original ids',
        () async {
      fakeRepo.removeException = Exception('firestore error');
      await container.read(authStateProvider.future);
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');

      await container
          .read(favouriteGamesNotifierProvider.notifier)
          .deleteSelected();

      final state = container.read(favouriteGamesNotifierProvider);
      expect(state, isA<FavouriteGamesSelecting>());
      expect((state as FavouriteGamesSelecting).selectedIds, {'game-1'});
    });

    test('no-op when not in selecting state', () async {
      await container
          .read(favouriteGamesNotifierProvider.notifier)
          .deleteSelected();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });
  });
}
