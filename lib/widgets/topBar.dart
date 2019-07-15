import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Function onRefreshButtonPressed;

  TopBar({this.title, this.onRefreshButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: onRefreshButtonPressed,
        ),
      ],
    );
  }
}
