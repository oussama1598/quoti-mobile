import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  TopBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
      ),
    );
  }
}
