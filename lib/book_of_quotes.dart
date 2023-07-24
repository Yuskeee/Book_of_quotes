
import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

class BookOfQuotes extends StatefulWidget {
  const BookOfQuotes({Key? key}) : super(key: key);

  @override
  State<BookOfQuotes> createState() => _BookOfQuotesState();
}

class _BookOfQuotesState extends State<BookOfQuotes> {
  final double _zFactor = 1.01;
  final double _xDisplacementToRight = -5;

  final _controllerPageFlip = GlobalKey<PageFlipWidgetState>();

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width * 0.8,
        MediaQuery.of(context).size.height * 0.8);
    return Row(
      // textDirection: TextDirection.rtl,
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(10),
        //       bottomRight: Radius.circular(10),
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Color.fromARGB(255, 106, 106, 106),
        //           offset: Offset(2, 5),
        //           blurRadius: 10),
        //     ],
        //   ),
        //   constraints: BoxConstraints(
        //     maxWidth: MediaQuery.of(context).size.width * 0.02,
        //     maxHeight: MediaQuery.of(context).size.height * 0.8,
        //   ),
        // ),
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
                  // lastPage: Container(
                  //     child: const Center(
                  //         child: Text('Last Quote So Far!',
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold,
                  //             )))),
                  cutoffForward: 0.5,
                  cutoffPrevious: 0.1,
                  children: <Widget>[
                    Container(
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
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              '“The best way to predict the future is to create it.”',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Abraham Lincoln',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              '“Hello, World!”',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Unknown',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              '“Hello, Erika!”',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Unknown',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ],
    );
  }
}
