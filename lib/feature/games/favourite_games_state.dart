import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_games_state.freezed.dart';

@freezed
sealed class FavouriteGamesState with _$FavouriteGamesState {
  const factory FavouriteGamesState.normal() = FavouriteGamesNormal;
  const factory FavouriteGamesState.selecting({required String gameId}) =
      FavouriteGamesSelecting;
  const factory FavouriteGamesState.deleting({required String gameId}) =
      FavouriteGamesDeleting;
}
