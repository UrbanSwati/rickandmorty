import 'package:meta/meta.dart';
import 'package:rickandmorty/core/domain/entities/character_location.dart';

class CharacterLocationModel extends CharacterLocation {

  CharacterLocationModel({
    @required String id,
    @required String name,
  }) : super(id: id, name: name);

  factory CharacterLocationModel.fromJson(Map<String, dynamic> jsonMap) {
    return CharacterLocationModel(id: jsonMap['id'], name: jsonMap['name']);
  }
}