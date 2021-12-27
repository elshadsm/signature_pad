import 'package:flutter/material.dart';

import 'signature_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Demo Home Page',
        ),
      ),
      body: Center(
        child: SignatureView(
          key: UniqueKey(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Clear',
        child: Icon(Icons.clear),
      ),
    );
  }
}
