import 'package:meta/meta.dart';
import 'package:rickandmorty/core/error/exception.dart';
import 'package:rickandmorty/core/error/failures.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:dartz/dartz.dart';
import 'package:rickandmorty/core/network/network_info.dart';
import 'package:rickandmorty/feature/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rickandmorty/feature/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final NetworkInfo networkInfo;
  final CharactersRemoteDataSource dataSource;

  CharactersRepositoryImpl({
    @required this.networkInfo,
    @required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    if (await networkInfo.isConnected == false) {
      return Left(NetworkFailure());
    }
    try {
      return Right(await dataSource.getCharacters(page));
    } on ServerException {
      return Left(ServerFailure());
    }
    
  }
}
