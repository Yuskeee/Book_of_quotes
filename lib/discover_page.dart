import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:recreating_ui/quote.dart';
import 'package:recreating_ui/quote_card.dart';
import 'package:recreating_ui/current_quote_handler.dart';

class WidgetAndQuote {
  Widget widget;
  Quote quote;

  WidgetAndQuote(this.widget, this.quote);
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  static const double cardWidth = 350;
  static const double cardHeight = 400;
  static const double nextCardHeightOffsetConst = -23;
  static const double nextCardWidthOffsetConst = 5;
  static const int animationDuration = 400;
  static const Curve animationCurve = Curves.easeOutSine;
  CurrentQuote currentQuote = CurrentQuote();
  late List<Future<Quote>> futureQuotes;

  // ignore: non_constant_identifier_names
  AnimationController? _SmoothCardsToFrontController;
  // ignore: non_constant_identifier_names
  Animation<double>? _SmoothCardsToFrontAnimationVertical;
  // ignore: non_constant_identifier_names
  Animation<double>? _SmoothCardsToFrontAnimationHorizontal;

  double nextCardHeightOffset = nextCardHeightOffsetConst;
  double nextCardWidthOffset = nextCardWidthOffsetConst;

  Future<Quote>? currentCardQuote;
  Future<Quote>? nextCardQuote;
  Future<Quote>? nextNextCardQuote;

  void refresh() {
    setState(() {});
  }

  WidgetAndQuote buildCardFromFuture(Future<Quote>? futureQuote) {
    Quote quote = const Quote(text: '', author: '');
    if (futureQuote == null) {
      return WidgetAndQuote(Container(), quote);
    }
    return WidgetAndQuote(
        FutureBuilder(
            future: futureQuote,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                quote = snapshot.data!;
                return Container(
                  constraints: const BoxConstraints(
                      maxHeight: cardHeight, maxWidth: cardWidth),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: QuoteCard(refresh, quote: snapshot.data!),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show an empty container.
              return Container();
            }),
        quote);
  }

  @override
  void initState() {
    super.initState();

    futureQuotes = currentQuote.getQuotes()!;
    currentCardQuote = futureQuotes[0];
    nextCardQuote = futureQuotes[1];
    nextNextCardQuote = futureQuotes[2];

    _SmoothCardsToFrontController = AnimationController(
      duration: const Duration(milliseconds: animationDuration),
      vsync: this,
    );
    _SmoothCardsToFrontAnimationVertical = Tween<double>(
      begin: nextCardHeightOffset,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _SmoothCardsToFrontController!,
      curve: animationCurve,
    ));
    _SmoothCardsToFrontController!.addListener(() {
      if (_SmoothCardsToFrontController!.isAnimating) {
        setState(() {
          nextCardHeightOffset = _SmoothCardsToFrontAnimationVertical!.value;
          nextCardWidthOffset = _SmoothCardsToFrontAnimationHorizontal!.value;
        });
      }
    });
    _SmoothCardsToFrontAnimationHorizontal = Tween<double>(
      begin: nextCardWidthOffset,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _SmoothCardsToFrontController!,
      curve: animationCurve,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_SmoothCardsToFrontController!.isCompleted) {
        // print('returning to original position');
        setState(() {});
        nextCardHeightOffset = nextCardHeightOffsetConst;
        nextCardWidthOffset = nextCardWidthOffsetConst;
        _SmoothCardsToFrontController!.reset();
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 56, 165, 255),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Stack of two cards in the background to give a stack effect
            Positioned(
              top: nextCardHeightOffset + nextCardHeightOffsetConst,
              right: nextCardWidthOffset + nextCardWidthOffsetConst,
              child: buildCardFromFuture(nextNextCardQuote).widget,
            ),
            Positioned(
              top: nextCardHeightOffset,
              right: nextCardWidthOffset,
              child: buildCardFromFuture(nextCardQuote).widget,
            ),
            // Current Card with animation
            Positioned(
              child: Draggable(
                onDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.distanceSquared >
                      100000) {
                    currentQuote.refreshQuote();
                    _SmoothCardsToFrontController!.reset();
                    currentCardQuote = null;
                    _SmoothCardsToFrontController!.forward().then((value) {
                      currentCardQuote = nextCardQuote;
                      nextCardQuote = nextNextCardQuote;
                      nextNextCardQuote = futureQuotes[3];
                      futureQuotes = currentQuote.removeFrontQuote();
                      setState(() {});
                    });
                  }
                },
                feedback: Container(
                  constraints: const BoxConstraints(
                      maxHeight: cardHeight, maxWidth: cardWidth),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: buildCardFromFuture(currentCardQuote).widget,
                ),
                childWhenDragging: Container(
                  constraints: const BoxConstraints(
                      maxHeight: cardHeight, maxWidth: cardWidth),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                child: Container(
                    constraints: const BoxConstraints(
                        maxHeight: cardHeight, maxWidth: cardWidth),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: buildCardFromFuture(currentCardQuote).widget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
