import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/domain/entities/character_episode.dart';
import 'package:rickandmorty/core/domain/entities/character_location.dart';
import 'package:rickandmorty/feature/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/feature/characters/domain/usecases/get_characters.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  GetCharactersUsecase usecase;
  MockCharactersRepository mockCharactersRepository;
  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    usecase = GetCharactersUsecase(mockCharactersRepository);
  });
  final List<Character> tCharacters = [
    Character(
      id: "1",
      name: "testname",
      imageUrl: "http://testurl.com",
      status: "alive",
      species: "human",
      origin: "test origin",
      gender: "gender test",
      type: "type test",
      location: CharacterLocation(id: "1", name: "Earth"),
      episodes: [CharacterEpisode(name: "test", episode: "test")],
    ),
    Character(
      id: "2",
      name: "testname",
      imageUrl: "http://testurl.com",
      status: "alive",
      species: "human",
      origin: "test origin",
      gender: "gender test",
      type: "type test",
      location: CharacterLocation(id: "1", name: "Earth"),
      episodes: [CharacterEpisode(name: "test", episode: "test")],
    ),
  ];

  test(
    'should get characters from the repository',
    () async {
      // arrange
      when(mockCharactersRepository.getCharacters(any))
          .thenAnswer((_) async => Right(tCharacters));
      // act
      final result = await usecase(Params(page: 1));
      // assert
      expect(result, Right(tCharacters));
      verify(mockCharactersRepository.getCharacters(1));
      verifyNoMoreInteractions(mockCharactersRepository);
    },
  );
}
