import 'package:flutter/material.dart';
import 'package:rickandmorty/core/domain/entities/character.dart';
import 'package:rickandmorty/core/domain/entities/character_episode.dart';
import 'package:rickandmorty/core/domain/entities/character_location.dart';
import 'package:rickandmorty/core/presentation/base_view.dart';
import 'package:rickandmorty/core/provider/view_state.dart';
import 'package:rickandmorty/feature/characters/presentation/providers/characters_provider.dart';
import 'package:rickandmorty/feature/characters/presentation/widgets/character_card.dart';

class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CharacterProvider>(
      onModelReady: (model) => model.fetchCharacters(),
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title:
              Text('Characters', style: Theme.of(context).textTheme.headline6),
          actions: <Widget>[
            InkWell(
              onTap: () async {
                provider.fetchCharacters();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.refresh, size: 30.0),
              ),
            )
          ],
        ),
        body: provider.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.state == ViewState.Error
                ? Center(
                    child: Text('Oops, something wrong happened'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: provider.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return provider.characters
                          .map((ch) => CharacterCard(ch))
                          .toList()[index];
                    },
                  ),
      ),
    );
  }
}
