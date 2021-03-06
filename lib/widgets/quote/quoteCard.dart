import 'package:flutter/material.dart';
import 'package:quoti/models/quote.dart';
import 'package:quoti/widgets/quote/bottomBar.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final MaterialColor cardColor;
  final Function toggleFavorite;

  QuoteCard(
      {this.quote,
      this.cardColor,
      this.toggleFavorite});

  Widget _buildQuoteContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Text(
            quote.quote,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: 15,
          ),
          alignment: Alignment.centerRight,
          child: Text(
            quote.author,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 1],
          colors: [
            cardColor[400],
            cardColor[900],
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildQuoteContent(context),
                )
              ],
            ),
          ),
          BottomBar(
            toggleFavorite: toggleFavorite,
            quote: quote,
          ),
        ],
      ),
    );
  }
}
