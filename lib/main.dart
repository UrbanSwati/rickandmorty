import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/feature/characters/presentation/providers/characters_provider.dart';
import 'package:rickandmorty/feature/characters/presentation/screens/characters_screen.dart';
import 'package:rickandmorty/injection_container.dart';

import 'core/constants.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
          primaryColor: kLightGrey,
          scaffoldBackgroundColor: kDarkGrey,
          textTheme: TextTheme(
            headline6:
                TextStyle(color: Colors.white, fontFamily: kGemunuLibreFont),
            bodyText1: TextStyle(
                color: Colors.white,
                fontFamily: kGemunuLibreFont,
                fontSize: 14.0),
            bodyText2: TextStyle(
                color: Color(0xFF959596),
                fontFamily: kGemunuLibreFont,
                fontSize: 14.0),
            headline1:
                TextStyle(color: Colors.white, fontFamily: kGemunuLibreFont),
            headline2:
                TextStyle(color: Colors.white, fontFamily: kGemunuLibreFont),
            headline4: TextStyle(
                color: Colors.white,
                fontFamily: kGemunuLibreFont,
                fontSize: 24.0),
            headline5: TextStyle(
                color: Colors.white,
                fontFamily: kGemunuLibreFont,
                fontSize: 18.0),
          ),
          colorScheme: ColorScheme.dark(primary: Color(0xFF3B3E44))),
      home: CharactersScreen(),
    );
  }
}
