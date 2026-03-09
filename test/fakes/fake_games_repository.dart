import 'package:mocktail/mocktail.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';
import 'package:simple_gaming_flutter/feature/games/games_repository.dart';

class FakeGamesRepository extends Fake implements GamesRepository {
  // Search
  List<Game> searchResult = [];
  Exception? searchException;

  // Add / Remove
  Exception? addException;
  Exception? removeException;
  final List<String> removedIds = [];

  @override
  Future<List<Game>> searchGames(String query) async {
    if (searchException != null) throw searchException!;
    return searchResult;
  }

  @override
  Future<void> addFavouriteGame(String userId, Game game) async {
    if (addException != null) throw addException!;
  }

  @override
  Future<void> removeFavouriteGame(String userId, String gameId) async {
    if (removeException != null) throw removeException!;
    removedIds.add(gameId);
  }

  @override
  Stream<List<Game>> observeFavouriteGames(String userId) => Stream.value([]);

  @override
  Stream<Set<String>> observeFavouriteGameIds(String userId) =>
      Stream.value({});
}
