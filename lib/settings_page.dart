import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipWidget(
        key: _controller,
        lastPage: Container(
          color: Colors.white,
          child: const Center(child: Text('Last Quote So Far!')),
        ),
        backgroundColor: Colors.white,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: const Center(child: Text('Page 1')),
          ),
          Container(
            color: Colors.green,
            child: const Center(child: Text('Page 2')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.looks_5_outlined),
        onPressed: () {
          _controller.currentState?.goToPage(4);
          setState(() {});
        },
      ),
    );
  }
}
