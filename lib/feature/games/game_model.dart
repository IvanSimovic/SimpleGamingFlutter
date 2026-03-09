import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';

@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    required String name,
    required String imageUrl,
  }) = _Game;
}
