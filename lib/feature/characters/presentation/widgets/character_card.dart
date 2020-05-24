import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:rickandmorty/core/constants.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/domain/entities/character_episode.dart';
import 'package:rickandmorty/core/domain/entities/character_location.dart';
import 'package:rickandmorty/feature/characters/presentation/screens/character_detail_screen.dart';
import 'package:rickandmorty/feature/characters/presentation/widgets/status_spicies.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard(this.character);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CharacterDetailScreen(character)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          type: MaterialType.card,
          elevation: 4.0,
          color: kLightGrey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(10.0),
                    topLeft: const Radius.circular(10.0),
                  ),
                  child: Container(
                    height: 170,
                    child: Hero(
                      tag: character.id,
                      child: ProgressiveImage(
                        placeholder: AssetImage(
                          'images/blur-image.png',
                        ),
                        thumbnail: AssetImage(
                          'images/blur-image.png',
                        ),
                        width: 180,
                        height: 170,
                        image: NetworkImage(
                          character.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: _CharacterDescription(
                  name: character.name,
                  status: character.status,
                  species: character.species,
                  gender: character.gender,
                  episodes: character.episodes,
                  location: character.location,
                  origin: character.origin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterDescription extends StatelessWidget {
  const _CharacterDescription({
    Key key,
    this.name,
    this.status,
    this.species,
    this.gender,
    this.episodes,
    this.location,
    this.origin,
  }) : super(key: key);

  final String name;
  final String status;
  final String species;
  final String gender;
  final List<CharacterEpisode> episodes;
  final String origin;
  final CharacterLocation location;

  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline4,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
      StatusSpecies(status: status, species: species),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
      Text(
        'Last known location',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
      Text(
        '${location.name}',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
      Text(
        'First seen in',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
      Text(
        '${episodes[0].name}',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children2,
      ),
    );
  }
}
