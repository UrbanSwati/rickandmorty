import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


class NoParams extends Equatable {
  // To be used on repos that don't require params
  @override
  List<Object> get props => [];
}