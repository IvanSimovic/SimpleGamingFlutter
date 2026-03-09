import 'package:mocktail/mocktail.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';
import 'package:simple_gaming_flutter/feature/reels/reels_repository.dart';

class FakeReelsRepository extends Fake implements ReelsRepository {
  List<ReelGame> fetchResult = [];
  bool hasMore = false;
  Exception? fetchException;

  // Tracks which pages were requested so tests can verify pagination.
  final List<int> requestedPages = [];

  @override
  Future<({List<ReelGame> games, bool hasMore})> fetchGames({
    required int page,
  }) async {
    requestedPages.add(page);
    if (fetchException != null) throw fetchException!;
    return (games: fetchResult, hasMore: hasMore);
  }
}
