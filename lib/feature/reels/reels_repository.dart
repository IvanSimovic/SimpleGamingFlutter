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
class _PlatformApiModel {
  const _PlatformApiModel({required this.name});

  final String name;

  factory _PlatformApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformApiModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class _PlatformWrapperApiModel {
  const _PlatformWrapperApiModel({required this.platform});

  final _PlatformApiModel platform;

  factory _PlatformWrapperApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformWrapperApiModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class _ReelGameApiModel {
  const _ReelGameApiModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    required this.genres,
    this.metacritic,
    required this.platforms,
    required this.playtime,
  });

  final int id;
  final String name;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;
  @JsonKey(defaultValue: 0.0)
  final double rating;
  final List<_GenreApiModel> genres;
  final int? metacritic;
  @JsonKey(defaultValue: [])
  final List<_PlatformWrapperApiModel> platforms;
  @JsonKey(defaultValue: 0)
  final int playtime;

  factory _ReelGameApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReelGameApiModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class _GameDetailApiModel {
  const _GameDetailApiModel({this.descriptionRaw});

  @JsonKey(name: 'description_raw')
  final String? descriptionRaw;

  factory _GameDetailApiModel.fromJson(Map<String, dynamic> json) =>
      _$GameDetailApiModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class _ScreenshotApiModel {
  const _ScreenshotApiModel({required this.image});

  final String image;

  factory _ScreenshotApiModel.fromJson(Map<String, dynamic> json) =>
      _$ScreenshotApiModelFromJson(json);
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
            metacritic: e.metacritic,
            platforms: e.platforms.map((p) => p.platform.name).toList(),
            playtime: e.playtime,
          ),
        )
        .toList();
    return (games: games, hasMore: hasMore);
  }

  Future<({String description, List<String> screenshots})> fetchGameDetail(
    String id,
  ) async {
    final detailFuture = _dio.get<Map<String, dynamic>>('/games/$id');
    final screenshotsFuture = _dio.get<Map<String, dynamic>>(
      '/games/$id/screenshots',
    );

    final responses = await Future.wait([detailFuture, screenshotsFuture]);

    final detail = _GameDetailApiModel.fromJson(responses[0].data!);
    final screenshotResults = responses[1].data!['results'] as List<dynamic>;
    final screenshots = screenshotResults
        .map((e) => _ScreenshotApiModel.fromJson(e as Map<String, dynamic>))
        .map((e) => e.image)
        .toList();

    return (description: detail.descriptionRaw ?? '', screenshots: screenshots);
  }
}
