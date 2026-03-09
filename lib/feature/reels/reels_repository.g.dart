// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reels_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenreApiModel _$GenreApiModelFromJson(Map<String, dynamic> json) =>
    _GenreApiModel(name: json['name'] as String);

_PlatformApiModel _$PlatformApiModelFromJson(Map<String, dynamic> json) =>
    _PlatformApiModel(name: json['name'] as String);

_PlatformWrapperApiModel _$PlatformWrapperApiModelFromJson(
  Map<String, dynamic> json,
) => _PlatformWrapperApiModel(
  platform: _PlatformApiModel.fromJson(
    json['platform'] as Map<String, dynamic>,
  ),
);

_ReelGameApiModel _$ReelGameApiModelFromJson(Map<String, dynamic> json) =>
    _ReelGameApiModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => _GenreApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metacritic: (json['metacritic'] as num?)?.toInt(),
      platforms:
          (json['platforms'] as List<dynamic>?)
              ?.map(
                (e) => _PlatformWrapperApiModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      playtime: (json['playtime'] as num?)?.toInt() ?? 0,
    );

_GameDetailApiModel _$GameDetailApiModelFromJson(Map<String, dynamic> json) =>
    _GameDetailApiModel(descriptionRaw: json['description_raw'] as String?);

_ScreenshotApiModel _$ScreenshotApiModelFromJson(Map<String, dynamic> json) =>
    _ScreenshotApiModel(image: json['image'] as String);
