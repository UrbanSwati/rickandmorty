import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/error/failures.dart';
import 'package:rickandmorty/core/provider/base_provider.dart';
import 'package:rickandmorty/core/provider/view_state.dart';
import 'package:rickandmorty/feature/characters/domain/usecases/get_characters.dart';
import 'package:rickandmorty/injection_container.dart';

class CharacterProvider extends BaseProvider {
  GetCharactersUsecase _charactersUsecase = sl<GetCharactersUsecase>();
  Random _random = Random();
  List<Character> _characters = [];

  List<Character> get characters => _characters;

  Future<void> fetchCharacters() async {
    setState(ViewState.Busy);
    
    int randomNumber = _random.nextInt(30) + 1;
    
    Either<Failure, List<Character>> results = await _charactersUsecase(Params(page: randomNumber));

    results.fold(
      (failure) {
        setState(ViewState.Error);
      },
      (List<Character> characters) {
        _characters = characters;
        setState(ViewState.Idle);
      },
    );
  }
}
