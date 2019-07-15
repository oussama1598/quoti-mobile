import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quoti/models/quote.dart';
import 'package:quoti/scoped-models/quotes.dart';
import 'package:quoti/widgets/loadingSpinner.dart';
import 'package:quoti/widgets/quote/quoteCard.dart';
import 'package:quoti/widgets/topBar.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritesPage extends StatefulWidget {
  final QuotesModel quotesModel;

  FavoritesPage({this.quotesModel});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _random = new Random();

  @override
  void initState() {
    widget.quotesModel.loadFavoriteQuotes();

    super.initState();
  }

  int _randomFromRange(int min, int max) => min + _random.nextInt(max - min);

  List<Widget> _buildQuotesCards(QuotesModel model) {
    final List<MaterialColor> colors = [
      Colors.orange,
      Colors.green,
      Colors.pink,
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.deepOrange,
      Colors.purple
    ];

    if (model.isLoading) return [LoadingSpinner()];
    if (model.favoriteQuotes.length == 0)
      return [
        Center(
          child: Text('No favorited quotes.'),
        )
      ];

    return List<Widget>.from(model.favoriteQuotes.map(
      (Quote quote) => QuoteCard(
        quote: quote,
        cardColor: colors[_randomFromRange(0, colors.length - 1)],
        toggleFavorite: model.toggleFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, QuotesModel model) {
          return Stack(
            children: <Widget>[
              PageView(
                children: _buildQuotesCards(model),
              ),
              TopBar(
                title: 'Favorites',
              ),
            ],
          );
        },
      ),
    );
  }
}
