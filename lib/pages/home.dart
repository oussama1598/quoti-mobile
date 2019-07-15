import 'package:flutter/material.dart';
import 'package:quoti/models/quote.dart';
import 'package:quoti/scoped-models/quotes.dart';
import 'package:quoti/widgets/loadingSpinner.dart';
import 'package:quoti/widgets/quote/quoteCard.dart';
import 'package:quoti/widgets/topBar.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  final QuotesModel quotesModel;

  HomePage({this.quotesModel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.quotesModel.fetchDailyQuote();

    super.initState();
  }

  List<Widget> _buildQuotesCards(QuotesModel model) {
    final List<MaterialColor> colors = [
      Colors.orange,
      Colors.green,
      Colors.pink,
      Colors.blue,
      Colors.red
    ];

    if (model.isLoading) return [LoadingSpinner()];

    return List<Widget>.from(model.todaysQuotes
        .asMap()
        .map(
          (int index, Quote quote) => MapEntry(
            index,
            QuoteCard(
              quote: quote.quote,
              author: quote.author,
              cardColor: colors[index],
            ),
          ),
        )
        .values
        .toList());
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
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: TopBar(
                  title: 'Quoti',
                  onRefreshButtonPressed:
                      model.isLoading ? null : model.fetchDailyQuote,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
