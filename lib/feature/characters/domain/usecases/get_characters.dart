import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/domain/usecases/usecase.dart';
import 'package:rickandmorty/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/feature/characters/domain/repositories/characters_repository.dart';

class GetCharactersUsecase implements UseCase<List<Character>, Params>{
  final CharactersRepository repository;

  GetCharactersUsecase(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) async {
    return await repository.getCharacters(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page});

  @override
  List<Object> get props => [page];
}