import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rickandmorty/core/data/models/character_episode_model.dart';
import 'package:rickandmorty/core/data/models/character_location_model.dart';
import 'package:rickandmorty/core/data/models/character_model.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/error/exception.dart';
import 'package:rickandmorty/core/error/failures.dart';
import 'package:rickandmorty/core/network/network_info.dart';
import 'package:rickandmorty/feature/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rickandmorty/feature/characters/data/repositories/characters_repository_impl.dart';

class MockRemoteDataSource extends Mock implements CharactersRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CharactersRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CharactersRepositoryImpl(
        dataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  group('getCharaters', () {
    final List<CharacterModel> tCharactersModels = [
      CharacterModel(
        id: "1",
        name: "testname",
        imageUrl: "http://testurl.com",
        status: "alive",
        species: "human",
        origin: "test origin",
        gender: "gender test",
        type: "type test",
        location: CharacterLocationModel(id: "1", name: "Earth"),
        episodes: [CharacterEpisodeModel(name: "test", episode: "test")],
      ),
      CharacterModel(
        id: "2",
        name: "testname",
        imageUrl: "http://testurl.com",
        status: "alive",
        species: "human",
        origin: "test origin",
        gender: "gender test",
        type: "type test",
        location: CharacterLocationModel(id: "1", name: "Earth"),
        episodes: [CharacterEpisodeModel(name: "test", episode: "test")],
      ),
    ];

    final List<Character> tCharaters = tCharactersModels;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getCharacters(1);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCharacters(any))
              .thenAnswer((_) async => tCharactersModels);
          // act
          final results = await repository.getCharacters(1);
          // assert
          verify(mockRemoteDataSource.getCharacters(1));
          expect(results, equals(Right(tCharaters)));
        },
      );
    });

     test(
        'should return ServerFailure when the call is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCharacters(any))
              .thenThrow(ServerException());
          // act
          final results = await repository.getCharacters(1);
          // assert
          verify(mockRemoteDataSource.getCharacters(1));
          expect(results, equals(Left(ServerFailure())));
        },
      );

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
         'should return Network Failure when network is down',
         () async {
          // act
          final results = await repository.getCharacters(1);
          // assert
          verifyNever(mockRemoteDataSource.getCharacters(1));
          expect(results, Left(NetworkFailure()));
        },
      );
    });
  });
}
