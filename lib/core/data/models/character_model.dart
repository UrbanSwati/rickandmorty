import 'package:rickandmorty/core/data/models/character_episode_model.dart';
import 'package:rickandmorty/core/data/models/character_location_model.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:meta/meta.dart';

class CharacterModel extends Character {
  CharacterModel({
    @required String id,
    @required String name,
    @required String imageUrl,
    @required String status,
    @required String species,
    @required String gender,
    @required String type,
    @required String origin,
    @required CharacterLocationModel location,
    @required List<CharacterEpisodeModel> episodes,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          location: location,
          gender: gender,
          species: species,
          type: type,
          origin: origin,
          status: status,
          episodes: episodes,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> jsonMap) {
    List<CharacterEpisodeModel> episodes = [];

    for (Map<String, dynamic> episodeJson in (jsonMap['episode'] as List)) {
      episodes.add(CharacterEpisodeModel.fromJson(episodeJson));
    }

    return CharacterModel(
      id: jsonMap['id'],
      name: jsonMap['name'],
      gender: jsonMap['gender'],
      status: jsonMap['status'],
      species: jsonMap['species'],
      imageUrl: jsonMap['image'],
      type: jsonMap['type'],
      origin: jsonMap['origin']['name'],
      episodes: episodes,
      location: CharacterLocationModel.fromJson(jsonMap['location']),
    );
  }
}
