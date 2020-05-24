import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CharacterLocation extends Equatable {
  final String id;
  final String name;

  CharacterLocation({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
