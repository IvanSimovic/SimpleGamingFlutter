import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_gaming_flutter/core/network/network_providers.dart';
import 'package:simple_gaming_flutter/feature/games/game_model.dart';

part 'games_repository.g.dart';

final gamesRepositoryProvider = Provider<GamesRepository>(
  (ref) => GamesRepository(ref.watch(dioProvider), FirebaseFirestore.instance),
);

// API model — internal, not exposed outside this file
@JsonSerializable(createToJson: false)
class _GameApiModel {
  const _GameApiModel({
    required this.id,
    required this.name,
    this.backgroundImage,
  });

  final int id;
  final String name;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;

  factory _GameApiModel.fromJson(Map<String, dynamic> json) =>
      _$GameApiModelFromJson(json);
}

const _collectionUsers = 'users';
const _collectionFavouriteGames = 'favouriteGames';
const _fieldGameId = 'gameId';
const _fieldName = 'name';
const _fieldImageUrl = 'imageUrl';
const _fieldAddedAt = 'addedAt';

class GamesRepository {
  GamesRepository(this._dio, this._firestore);

  final Dio _dio;
  final FirebaseFirestore _firestore;

  Future<List<Game>> searchGames(String query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games',
      queryParameters: {'search': query, 'page_size': 20},
    );
    final results = response.data!['results'] as List<dynamic>;
    return results
        .map((e) => _GameApiModel.fromJson(e as Map<String, dynamic>))
        .map(
          (e) => Game(
            id: e.id.toString(),
            name: e.name,
            imageUrl: e.backgroundImage ?? '',
          ),
        )
        .toList();
  }

  Stream<Set<String>> observeFavouriteGameIds(String userId) => _firestore
      .collection(_collectionUsers)
      .doc(userId)
      .collection(_collectionFavouriteGames)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => doc.data()[_fieldGameId] as String? ?? '')
            .where((id) => id.isNotEmpty)
            .toSet(),
      );

  Stream<List<Game>> observeFavouriteGames(String userId) => _firestore
      .collection(_collectionUsers)
      .doc(userId)
      .collection(_collectionFavouriteGames)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) {
              final data = doc.data();
              return Game(
                id: data[_fieldGameId] as String? ?? '',
                name: data[_fieldName] as String? ?? '',
                imageUrl: data[_fieldImageUrl] as String? ?? '',
              );
            })
            .where((g) => g.id.isNotEmpty)
            .toList(),
      );

  Future<void> addFavouriteGame(String userId, Game game) => _firestore
      .collection(_collectionUsers)
      .doc(userId)
      .collection(_collectionFavouriteGames)
      .doc(game.id)
      .set({
        _fieldGameId: game.id,
        _fieldName: game.name,
        _fieldImageUrl: game.imageUrl,
        _fieldAddedAt: FieldValue.serverTimestamp(),
      });

  Future<void> removeFavouriteGame(String userId, String gameId) => _firestore
      .collection(_collectionUsers)
      .doc(userId)
      .collection(_collectionFavouriteGames)
      .doc(gameId)
      .delete();
}
