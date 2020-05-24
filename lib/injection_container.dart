import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/feature/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rickandmorty/feature/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/feature/characters/domain/repositories/characters_repository.dart';
import 'package:rickandmorty/feature/characters/domain/usecases/get_characters.dart';
import 'package:rickandmorty/feature/characters/presentation/providers/characters_provider.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Characters
  // Provider
  sl.registerLazySingleton(() => CharacterProvider());

  // Use Case
  sl.registerLazySingleton(() => GetCharactersUsecase(sl()));

  // Repository
  sl.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(networkInfo: sl(), dataSource: sl()));

  // Data sources
  sl.registerLazySingleton<CharactersRemoteDataSource>(
      () => CharactersRemoteDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton(
    () => GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(
        uri: 'https://rickandmortyapi.com/graphql',
      ),
    ),
  );
  
}
