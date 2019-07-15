import 'package:flutter/material.dart';
import 'package:quoti/models/quote.dart';
import 'package:share/share.dart';

class BottomBar extends StatelessWidget {
  final Function toggleFavorite;
  final Quote quote;

  BottomBar({this.toggleFavorite, this.quote});

  void _onShareButtonPressed() {
    Share.share(
        'Check out this amazing quote By ${quote.author}: ${quote.quote}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              quote.isFavorited ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => toggleFavorite(quote.id),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _onShareButtonPressed,
          ),
        ],
      ),
    );
  }
}
