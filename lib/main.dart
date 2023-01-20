import 'package:flutter/material.dart';

void main() {
  runApp(const Biscotto());
}

class Biscotto extends StatelessWidget {
  const Biscotto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biscotto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BiscottoSearchPage(title: 'Biscotto Search Page'),
    );
  }
}

class BiscottoSearchPage extends StatefulWidget {
  const BiscottoSearchPage({super.key, required this.title});

  final String title;

  @override
  State<BiscottoSearchPage> createState() => _BiscottoSearchPageState();
}

class _BiscottoSearchPageState extends State<BiscottoSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
