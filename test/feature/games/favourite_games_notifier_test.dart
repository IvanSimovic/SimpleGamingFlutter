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
        authStateProvider.overrideWith((_) => Stream.value(FakeFirebaseUser())),
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
      expect((state as FavouriteGamesSelecting).gameId, 'game-1');
    });
  });

  group('cancelSelection', () {
    test('returns to normal from selecting state', () {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      container.read(favouriteGamesNotifierProvider.notifier).cancelSelection();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });
  });

  group('delete', () {
    test('successful delete returns to normal state', () async {
      container
          .read(favouriteGamesNotifierProvider.notifier)
          .onLongPress('game-1');
      await container.read(authStateProvider.future);
      await container.read(favouriteGamesNotifierProvider.notifier).delete();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
    });

    test(
      'successful delete calls removeFavouriteGame with the selected id',
      () async {
        container
            .read(favouriteGamesNotifierProvider.notifier)
            .onLongPress('game-1');
        await container.read(authStateProvider.future);
        await container.read(favouriteGamesNotifierProvider.notifier).delete();

        expect(fakeRepo.removedIds, contains('game-1'));
      },
    );

    test(
      'repository failure restores selecting state with original id',
      () async {
        fakeRepo.removeException = Exception('firestore error');
        container
            .read(favouriteGamesNotifierProvider.notifier)
            .onLongPress('game-1');
        await container.read(authStateProvider.future);
        await container.read(favouriteGamesNotifierProvider.notifier).delete();

        final state = container.read(favouriteGamesNotifierProvider);
        expect(state, isA<FavouriteGamesSelecting>());
        expect((state as FavouriteGamesSelecting).gameId, 'game-1');
      },
    );

    test('no-op when not in selecting state', () async {
      await container.read(favouriteGamesNotifierProvider.notifier).delete();

      expect(
        container.read(favouriteGamesNotifierProvider),
        isA<FavouriteGamesNormal>(),
      );
      expect(fakeRepo.removedIds, isEmpty);
    });
  });
}
