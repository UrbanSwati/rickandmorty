import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql/language.dart';
import 'package:mockito/mockito.dart';
import 'package:graphql/client.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/error/failures.dart';
import 'package:rickandmorty/core/network/network_info.dart';
import 'package:rickandmorty/feature/characters/data/datasources/characters_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/feature/characters/data/repositories/characters_repository_impl.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/helpers.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
void main() {
  const String readCharacters = r'''
      query {
        characters (page: $page) {
          info {
            pages
            next
          }
          results {
            id
            
            name
            image
            status
            species
            type
            location {
              id
              name
            }
            episode  {
              name
              episode
            }
          }
        }
      }
      ''';

  CharactersRemoteDataSourceImpl charactersSource;
  HttpLink httpLink;
  GraphQLClient graphQLClientClient;
  MockHttpClient mockHttpClient;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHttpClient = MockHttpClient();

    httpLink = HttpLink(
        uri: 'https://api.github.com/graphql', httpClient: mockHttpClient);

    graphQLClientClient = GraphQLClient(
      cache: getTestCache(),
      link: httpLink,
    );
    mockNetworkInfo = MockNetworkInfo();
    charactersSource = CharactersRemoteDataSourceImpl(graphQLClientClient);
  });

  test(
    'should perform graphql query and return fixture',
    () async {
      // arrange
      final WatchQueryOptions _options = WatchQueryOptions(
        documentNode: parseString(readCharacters),
        variables: <String, dynamic>{
          'page': 1,
        },
      );

      when(mockHttpClient.send(any)).thenAnswer((Invocation a) async {
        return simpleResponse(body: fixture('characters.json'));
      });

      // act
      final QueryResult results = await graphQLClientClient.query(_options);

      final http.Request capt = verify(mockHttpClient.send(captureAny))
          .captured
          .first as http.Request;

      // assert
      expect(capt.method, 'post');
      expect(capt.url.toString(), 'https://api.github.com/graphql');
      expect(results.exception, isNull);
      expect(results.data, isNotNull);

      final List<dynamic> characters =
          (results.data['characters']['results'] as List<dynamic>);

      expect(characters, hasLength(20));
      expect(characters[0]['name'], equals("E. Coli"));
      expect(characters[3]['name'], equals("Doom-Nomitron"));
    },
  );

  group('characters Datasource', () {
    test(
      'should return Charaters when query characters',
      () async {
        // arrange
        when(mockHttpClient.send(any)).thenAnswer((Invocation a) async {
          return simpleResponse(body: fixture('characters.json'));
        });

        // act
        final List<Character> charactersResults =
            await charactersSource.getCharacters(1);

        // assert
        expect(charactersResults, hasLength(20));
      },
    );

    test(
      'should throw ServerExpection when query characters is unsuccessful',
      () async {
        // arrange
        when(mockHttpClient.send(any)).thenAnswer((Invocation a) async {
          throw Exception();
        });

        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        CharactersRepositoryImpl repo = CharactersRepositoryImpl(dataSource: charactersSource, networkInfo: mockNetworkInfo);
        // act
        final result = await repo.getCharacters(1);

        // assert
        expect(result, Left(ServerFailure()));
      },
    );
  });
}
