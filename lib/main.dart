import 'package:flutter/material.dart';
import 'package:quoti/pages/home.dart';
import 'package:quoti/scoped-models/quotes.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuotesModel _quotesModel = QuotesModel();

    return ScopedModel(
      model: _quotesModel,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: HomePage(
          quotesModel: _quotesModel,
        ),
      ),
    );
  }
}
