import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:quoti/models/quote.dart';

const String DAILY_QUOTE_URI = 'https://www.brainyquote.com/quote_of_the_day';

Future<List<Quote>> getDailyQuotes() async {
  final Client client = Client();
  final List<Quote> quotes = [];
  final Response response = await client.get(DAILY_QUOTE_URI);
  final Document document = parse(response.body);

  final List<Element> dailyQuotes = document.querySelectorAll('.m-brick.bqQt');

  for (Element quoteEl in dailyQuotes) {
    final String id =
        quoteEl.querySelector('.b-qt').attributes['class'].split(' ')[1].replaceAll('qt_', '');
    final String quote = quoteEl.querySelector('.b-qt').text;
    final String author = quoteEl.querySelector('.bq-aut').text;
    final List<String> topics = quoteEl
        .querySelectorAll('.qll-dsk-kw-box .qkw-btn')
        .map(
          (Element topicEl) => topicEl.text.toLowerCase(),
        )
        .toList();

    quotes.add(
      Quote(
        id: id,
        quote: quote,
        author: author,
        topics: topics,
      ),
    );
  }

  return quotes;
}
