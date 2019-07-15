import 'package:quoti/helpers/quotes.dart';
import 'package:quoti/models/quote.dart';
import 'package:scoped_model/scoped_model.dart';

class QuotesModel extends Model {
  List<Quote> _todaysQuotes = [];
  bool _loading = true;

  get todaysQuotes {
    return _todaysQuotes;
  }

  get isLoading {
    return _loading;
  }

  Future fetchDailyQuote() async {
    _loading = true;
    notifyListeners();
    
    _todaysQuotes = await getDailyQuotes();
    _loading = false;

    notifyListeners();
  }
}
