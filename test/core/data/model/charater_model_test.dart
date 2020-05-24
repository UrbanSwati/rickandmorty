import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rickandmorty/core/data/models/character_episode_model.dart';
import 'package:rickandmorty/core/data/models/character_location_model.dart';
import 'package:rickandmorty/core/data/models/character_model.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tCharaterModel = CharacterModel(
    id: "5",
    name: "Jerry Smith",
    type: "",
    gender: "Male",
    origin: "Earth (Replacement Dimension)",
    location: CharacterLocationModel(id: "20", name: "Earth (Replacement Dimension)"),
    episodes: [CharacterEpisodeModel(name: "Rick Potion #9", episode: "S01E06"), CharacterEpisodeModel(name: "Raising Gazorpazorp", episode: "S01E07")],
    imageUrl: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
    species: "Human",
    status: "Alive"
  );

  test(
    'should be a subclass of Charater Entity',
    () async {
      // assert
      expect(tCharaterModel, isA<Character>());
    },
  );

  group('fromJson', () {
    test(
       'should return a valid model when is JSON',
       () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('character.json'));
        // act
        final result = CharacterModel.fromJson(jsonMap['data']['character']);
        // assert
        expect(result, tCharaterModel);
        expect(result, isA<Character>());
      },
    );
  });
}
