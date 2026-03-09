import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';

part 'reels_state.freezed.dart';

@freezed
sealed class ReelsState with _$ReelsState {
  const factory ReelsState.loading() = ReelsLoading;
  const factory ReelsState.content({
    required List<ReelGame> games,
    required int currentIndex,
    required bool isLoadingMore,
    required bool hasReachedEnd,
    required Set<String> favouritingIds,
  }) = ReelsContent;
  const factory ReelsState.empty() = ReelsEmpty;
  const factory ReelsState.error() = ReelsError;
}
