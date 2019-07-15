import 'package:quoti/helpers/quotes.dart';
import 'package:quoti/models/quote.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class QuotesModel extends Model {
  Database database;

  List<Quote> _storedFavoriteQuotes = [];
  List<Quote> _todaysQuotes = [];
  bool _loading = true;

  get todaysQuotes {
    return List<Quote>.from(_todaysQuotes);
  }

  get favoriteQuotes {
    return List<Quote>.from(_storedFavoriteQuotes);
  }

  get isLoading {
    return _loading;
  }

  Future fetchDailyQuote() async {
    _loading = true;
    notifyListeners();

    _todaysQuotes = await getDailyQuotes();

    await Future.forEach(_todaysQuotes, (Quote quote) async {
      quote.isFavorited = await isFavorited(quote.id);
    });

    _loading = false;
    notifyListeners();
  }

  Future loadDatabase() async {
    if (database != null) return;

    database = await openDatabase(
      'quoti.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE favorites (id INTEGER PRIMARY KEY, author TEXT, quote TEXT, topics TEXT)');
      },
    );
  }

  Future<bool> isFavorited(String id) async {
    final List<Map<String, dynamic>> records =
        await database.query('favorites', where: 'id = ?', whereArgs: [id]);

    return records.length > 0;
  }

  void toggleFavorite(String id) async {
    print(id);

    final Quote quote =
        _todaysQuotes.firstWhere((Quote quote) => quote.id == id);

    if (!quote.isFavorited)
      await database.insert(
        'favorites',
        {
          'id': id,
          'author': quote.author,
          'quote': quote.quote,
          'topics': quote.topics.join(', '),
        },
      );
    else {
      await database.delete('favorites', where: 'id = ?', whereArgs: [id]);
      _storedFavoriteQuotes.removeWhere((Quote quote) => quote.id == id);
    }
    quote.isFavorited = !quote.isFavorited;

    notifyListeners();
  }

  void loadFavoriteQuotes() async {
    final List<Map<String, dynamic>> records =
        await database.query('favorites');

    _storedFavoriteQuotes = List<Quote>.from(records
        .map(
          (Map<String, dynamic> quoteRecord) => Quote(
            id: quoteRecord['id'].toString(),
            author: quoteRecord['author'],
            quote: quoteRecord['quote'],
            topics: quoteRecord['topics'].split(', '),
            isFavorited: true,
          ),
        )
        .toList());

    notifyListeners();
  }
}
