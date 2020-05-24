import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CharacterEpisode extends Equatable {
  final String name;
  final String episode;

  CharacterEpisode({@required this.name, @required this.episode});

  @override
  List<Object> get props => [name, episode];
}
