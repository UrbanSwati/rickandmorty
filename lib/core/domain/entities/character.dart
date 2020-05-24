import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/core/domain/entities/character_episode.dart';

import 'character_location.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String gender;
  final String imageUrl;
  final String status;
  final String species;
  final String origin;
  final String type;
  final CharacterLocation location;
  final List<CharacterEpisode> episodes;

  Character({
    @required this.id,
    @required this.name,
    @required this.gender,
    @required this.imageUrl,
    @required this.status,
    @required this.species,
    @required this.origin,
    @required this.type,
    @required this.location,
    @required this.episodes,
  });

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
        status,
        gender,
        species,
        origin,
        type,
        location,
        episodes,
      ];
}
