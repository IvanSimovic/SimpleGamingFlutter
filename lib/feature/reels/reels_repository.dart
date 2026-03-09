import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_gaming_flutter/core/network/network_providers.dart';
import 'package:simple_gaming_flutter/feature/reels/reel_game_model.dart';

part 'reels_repository.g.dart';

final reelsRepositoryProvider = Provider<ReelsRepository>(
  (ref) => ReelsRepository(ref.watch(dioProvider)),
);

@JsonSerializable(createToJson: false)
class _GenreApiModel {
  const _GenreApiModel({required this.name});

  final String name;

  factory _GenreApiModel.fromJson(Map<String, dynamic> json) =>
      _$GenreApiModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class _ReelGameApiModel {
  const _ReelGameApiModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    required this.genres,
  });

  final int id;
  final String name;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;
  @JsonKey(defaultValue: 0.0)
  final double rating;
  final List<_GenreApiModel> genres;

  factory _ReelGameApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReelGameApiModelFromJson(json);
}

class ReelsRepository {
  ReelsRepository(this._dio);

  final Dio _dio;

  Future<({List<ReelGame> games, bool hasMore})> fetchGames({
    required int page,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games',
      queryParameters: {'page': page, 'page_size': 20, 'ordering': '-added'},
    );
    final data = response.data!;
    final hasMore = data['next'] != null;
    final results = data['results'] as List<dynamic>;
    final games = results
        .map((e) => _ReelGameApiModel.fromJson(e as Map<String, dynamic>))
        .map(
          (e) => ReelGame(
            id: e.id.toString(),
            name: e.name,
            imageUrl: e.backgroundImage ?? '',
            rating: e.rating,
            genres: e.genres.map((g) => g.name).toList(),
          ),
        )
        .toList();
    return (games: games, hasMore: hasMore);
  }
}
