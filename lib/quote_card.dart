import 'package:flutter/material.dart';

import 'package:recreating_ui/quote.dart';
import 'package:recreating_ui/favorites_handler.dart';

class QuoteCard extends StatefulWidget {
  Function callback;

  QuoteCard(this.callback, {Key? key, required this.quote}) : super(key: key);

  final Quote quote;

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        // Add or remove the quote from favorites
        setState(() {
          if (Favorites.containsQuote(widget.quote)) {
            Favorites.removeQuote(widget.quote);
          } else {
            Favorites.addQuote(widget.quote);
          }
        });
        widget.callback();
      },
      child: Card(
        color: Colors.white,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          1,
        ),
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.quote.text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  // Icon representing whether the quote is in favorites
                  MouseRegion(
                    // change cursor when hovered
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTapDown: (details) {
                        // Add or remove the quote from favorites
                        setState(() {
                          if (Favorites.containsQuote(widget.quote)) {
                            Favorites.removeQuote(widget.quote);
                          } else {
                            Favorites.addQuote(widget.quote);
                          }
                        });
                        widget.callback();
                      },
                      child: Icon(
                        Favorites.containsQuote(widget.quote)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '-${widget.quote.author}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 108, 107, 165)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
