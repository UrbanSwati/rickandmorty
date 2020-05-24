
import 'package:flutter/material.dart';

class StatusSpecies extends StatelessWidget {
  const StatusSpecies({
    Key key,
    @required this.status,
    @required this.species,
    this.alignCenter = false,
  }) : super(key: key);

  final String status;
  final String species;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 13.0,
          height: 13.0,
          decoration: new BoxDecoration(
            color: status == 'Dead' ? Colors.red : Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
        Text(
          '$status - $species',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
