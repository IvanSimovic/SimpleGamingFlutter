import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gaming_flutter/feature/auth/auth_providers.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_notifier.dart';
import 'package:simple_gaming_flutter/feature/games/add_game_state.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_notifier.dart';
import 'package:simple_gaming_flutter/feature/games/favourite_games_state.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

final addGameNotifierProvider =
    NotifierProvider.autoDispose<AddGameNotifier, AddGameState>(
  AddGameNotifier.new,
);

final favouriteGamesProvider = StreamProvider<List<Game>>((ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid;
  if (userId == null) return const Stream.empty();
  return ref.watch(gamesRepositoryProvider).observeFavouriteGames(userId);
});

final favouriteGameIdsProvider = Provider.autoDispose<Set<String>>((ref) {
  return ref.watch(favouriteGamesProvider).valueOrNull?.map((g) => g.id).toSet() ?? {};
});

final favouriteGamesNotifierProvider =
    NotifierProvider.autoDispose<FavouriteGamesNotifier, FavouriteGamesState>(
  FavouriteGamesNotifier.new,
);
