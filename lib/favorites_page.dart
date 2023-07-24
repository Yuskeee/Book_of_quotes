import 'package:flutter/material.dart';
import 'quote.dart';

import 'package:recreating_ui/favorites_handler.dart';
import 'package:recreating_ui/quote_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Quote> quotes = Favorites.getQuotes();

    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 56, 165, 255),
      body: Center(
        child: quotes.isNotEmpty
            ? ListView.builder(
                itemCount: quotes.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return QuoteCard(() {}, quote: quotes[index]);
                },
              )
            : Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 56, 165, 255),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Text(
                  'No favorites yet!',
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 20,
                    ),
                  ]),
                )),
      ),
    );
  }
}
