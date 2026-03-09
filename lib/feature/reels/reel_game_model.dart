import 'package:freezed_annotation/freezed_annotation.dart';

part 'reel_game_model.freezed.dart';

@freezed
class ReelGame with _$ReelGame {
  const factory ReelGame({
    required String id,
    required String name,
    required String imageUrl,
    required double rating,
    required List<String> genres,
  }) = _ReelGame;
}
