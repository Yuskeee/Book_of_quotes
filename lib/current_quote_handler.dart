import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:recreating_ui/quote.dart';

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('https://type.fit/api/quotes'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // List<Quote> quote = [];
    // for (var quote in jsonDecode(response.body)) {
    //   quote.add(Quote.fromJson(quote));
    // }
    // // Get only a random quote
    // quote.shuffle();

    final jsonSize = jsonDecode(response.body).length;
    final randomIndex = Random().nextInt(jsonSize);
    return Quote.fromJson(jsonDecode(response.body)[randomIndex]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Quote');
  }
}

// Singleton class
class CurrentQuote {
  // ignore: non_constant_identifier_names
  static int NUMBER_OF_CARDS = 5;
  static final CurrentQuote _currentQuote = CurrentQuote._internal();

  CurrentQuote._internal();

  static List<Future<Quote>>? _quotes;

  factory CurrentQuote() {
    // Repeat NUMBER_OF_CARDS times
    _quotes ??= List<Future<Quote>>.generate(
      NUMBER_OF_CARDS,
      (int index) => fetchQuote(),
    );
    return _currentQuote;
  }

  void refreshQuote() async {
    if (_quotes == null) {
      _quotes = [fetchQuote()];
      return;
    }
    _quotes?.add(fetchQuote());
  }

  List<Future<Quote>> removeFrontQuote() {
    _quotes?.removeAt(0);
    return _quotes!;
  }

  List<Future<Quote>>? getQuotes() {
    return _quotes;
  }
}
