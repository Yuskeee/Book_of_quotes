import 'package:recreating_ui/quote.dart';

class Favorites {
  static final List<Quote> _quotes = [];

  static void addQuote(Quote quote) {
    _quotes.add(quote);
  }

  static void removeQuote(Quote quote) {
    _quotes.remove(quote);
  }

  static bool containsQuote(Quote quote) {
    return _quotes.contains(quote);
  }

  static List<Quote> getQuotes() {
    return _quotes;
  }
}
