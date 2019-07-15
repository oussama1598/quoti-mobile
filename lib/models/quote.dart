import 'package:flutter/material.dart';

class Quote{
  final String id;
  final String author;
  final String quote;
  final List<String> topics;

  Quote({
    @required this.id,
    @required this.author,
    @required this.quote,
    @required this.topics,
  });
}