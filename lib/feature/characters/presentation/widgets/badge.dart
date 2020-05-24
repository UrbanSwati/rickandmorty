import 'package:flutter/material.dart';
import 'package:rickandmorty/core/constants.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 39,
      height: 11,
      child: Center(
        child: Text(text,
            style: TextStyle(fontSize: 9.0, color: Colors.white)),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: kLightGrey),
    );
  }
}