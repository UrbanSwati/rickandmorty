import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({Key key, this.heading, this.body, this.customBody})
      : super(key: key);

  final String heading;
  final String body;
  final Widget customBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          heading,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        customBody == null
            ? Text(
                body == "" ? '-' : body,
                style: Theme.of(context).textTheme.bodyText1,
              )
            : customBody,
      ],
    );
  }
}
