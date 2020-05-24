import 'package:flutter/material.dart';
import 'package:rickandmorty/core/constants.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/feature/characters/presentation/widgets/info.dart';
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
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InfoDetail(
                                heading: 'Species', body: character.species),
                            InfoDetail(heading: 'Type', body: character.type),
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InfoDetail(
                                heading: 'Gender', body: character.gender),
                            InfoDetail(
                                heading: 'Origin', body: character.origin),
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InfoDetail(
                                heading: 'Location',
                                body: character.location.name),
                          ],
                        ),
                      ],
                    ),
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
