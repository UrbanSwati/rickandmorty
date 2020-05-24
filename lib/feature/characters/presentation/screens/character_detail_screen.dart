import 'package:flutter/material.dart';
import 'package:rickandmorty/core/constants.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/feature/characters/presentation/widgets/badge.dart';
import 'package:rickandmorty/feature/characters/presentation/widgets/status_spicies.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  CharacterDetailScreen(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 100, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: kDarkBlue,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(18.0),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Hero(
                          tag: character.id,
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(character.imageUrl),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            character.name,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        StatusSpecies(
                          status: character.status,
                          species: character.species,
                          alignCenter: true,
                        ),
                      ],
                    ),
                    LeftDetail(
                      top: 230,
                      child: Text("Species",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    LeftDetail(
                      top: 250,
                      child: Text(character.species,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    LeftDetail(
                      top: 290,
                      child: Text("Gender",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    LeftDetail(
                      top: 310,
                      child: Text(character.gender,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    LeftDetail(
                      top: 350,
                      child: Text("Location",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    LeftDetail(
                      top: 370,
                      child: Container(
                        width: 110,
                        child: Text(character.location.name,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    LeftDetail(
                      top: 410,
                      child: Text("Episodes",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    LeftDetail(
                      top: 430,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: character.episodes.map((e) => Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Badge(text: e.episode,),
                          )).toList(),
                        ),
                      ),
                    ),
                    RightDetail(
                      top: 230,
                      child: Text("Type",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    RightDetail(
                      top: 250,
                      child: Text(character.type == "" ? '-' : character.type,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    RightDetail(
                      top: 290,
                      child: Text("Origin",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    RightDetail(
                      top: 310,
                      child: Container(
                        width: 120,
                        child: Text(character.origin,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    RightDetail(
                      top: 350,
                      child: Text("First seen in",
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    FirstSeenIn(
                        name: character.episodes[0].name,
                        episode: character.episodes[0].episode),
                    Positioned(
                      top: 0,
                      left: 30,
                      child: InkWell(
                        onTap: () {
                          // Goes back where the Event Screen was called
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 42.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightDetail extends StatelessWidget {
  const RightDetail({
    Key key,
    @required this.top,
    @required this.child,
  }) : super(key: key);
  final double top;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: top,
      start: 195,
      child: child,
    );
  }
}

class LeftDetail extends StatelessWidget {
  const LeftDetail({
    Key key,
    @required this.top,
    @required this.child,
  }) : super(key: key);

  final double top;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: top,
      start: 80,
      child: child,
    );
  }
}

class FirstSeenIn extends StatelessWidget {
  const FirstSeenIn({
    Key key,
    @required this.episode,
    @required this.name,
  }) : super(key: key);

  final String episode;
  final String name;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 370,
      start: 195,
      child: Container(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name, style: Theme.of(context).textTheme.bodyText1),
            Badge(text: episode)
          ],
        ),
      ),
    );
  }
}
