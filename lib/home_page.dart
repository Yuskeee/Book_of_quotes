import 'dart:math';

import 'package:flutter/material.dart';

import 'package:recreating_ui/minimalistic_button.dart';
import 'package:recreating_ui/book_of_quotes.dart';
import 'package:recreating_ui/favorites_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bookOfQuotes_controller = GlobalKey<BookOfQuotesState>();

  int page = 0;
  void _generateRandomPage(int maxPages) {
    setState(() {
      page = Random().nextInt(maxPages);
      print(page);
      _bookOfQuotes_controller.currentState!.goToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(150, 56, 165, 255),
        body: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: BookOfQuotes(key: _bookOfQuotes_controller),
            ),
            const Spacer(),
            Center(
              child: MinimalisticButton(
                onPressed: () =>
                    _generateRandomPage(Favorites.getQuotes().length),
                //Assigns window height to the button height
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.blue,
                child: const Icon(
                  Icons.format_list_numbered_sharp,
                  color: Colors.white,
                  size: 25,
                  fill: 0.0,
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ],
        )));
  }
}
