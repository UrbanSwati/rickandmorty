import 'package:dartz/dartz.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/error/failures.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
}
