import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

import 'favorites_handler.dart';

class BookOfQuotes extends StatefulWidget {
  const BookOfQuotes({Key? key}) : super(key: key);

  @override
  State<BookOfQuotes> createState() => BookOfQuotesState();
}

class BookOfQuotesState extends State<BookOfQuotes> {
  final double _zFactor = 1.01;
  final double _xDisplacementToRight = -5;

  final _controllerPageFlip = GlobalKey<PageFlipWidgetState>();

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width * 0.8,
        MediaQuery.of(context).size.height * 0.8);

    // <Widget>[] of Favorite Quotes
    List<Widget> favoriteQuotes = Favorites.getQuotes().map((quote) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 106, 106, 106),
                offset: Offset(2, 5),
                blurRadius: 10),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8 * _zFactor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              quote.text,
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
              indent: 20,
              endIndent: 20,
            ),
            Text(
              quote.author,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'Futura',
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList();

    return Row(
      // textDirection: TextDirection.rtl,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.8 * (1 - 1.03) / 2,
              //     (1 - pow(_zFactor, 2)) /
              //     2,
              right: _xDisplacementToRight * 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 106, 106, 106),
                        offset: Offset(2, 5),
                        blurRadius: 10),
                  ],
                ),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.8 * 1.03
                    // *
                    // pow(_zFactor, 2),
                    ),
              ),
            ),
            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.8 * (1 - _zFactor) / 2,
              right: _xDisplacementToRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   bottomLeft: Radius.circular(10),
                  // ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 106, 106, 106),
                        offset: Offset(2, 5),
                        blurRadius: 10),
                  ],
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight:
                      MediaQuery.of(context).size.height * 0.8 * _zFactor,
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: PageFlipWidget(
                  key: _controllerPageFlip,
                  cutoffForward: 0.5,
                  cutoffPrevious: 0.1,
                  duration: const Duration(milliseconds: 450),
                  children: favoriteQuotes),
            ),
          ],
        ),
      ],
    );
  }

  void goToPage(int index) {
    _controllerPageFlip.currentState!.goToPage(index);
  }
}
