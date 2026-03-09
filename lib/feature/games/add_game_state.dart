import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';

part 'add_game_state.freezed.dart';

@freezed
sealed class AddGameState with _$AddGameState {
  const factory AddGameState.idle() = AddGameIdle;
  const factory AddGameState.loading() = AddGameLoading;
  const factory AddGameState.content(List<Game> results) = AddGameContent;
  const factory AddGameState.empty() = AddGameEmpty;
  const factory AddGameState.error() = AddGameError;
  const factory AddGameState.added() = AddGameAdded;
}
