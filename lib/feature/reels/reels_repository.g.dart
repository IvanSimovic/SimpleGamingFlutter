// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reels_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenreApiModel _$GenreApiModelFromJson(Map<String, dynamic> json) =>
    _GenreApiModel(name: json['name'] as String);

_ReelGameApiModel _$ReelGameApiModelFromJson(Map<String, dynamic> json) =>
    _ReelGameApiModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => _GenreApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
