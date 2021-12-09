import 'package:flutter/material.dart';

class ConvertCurrency extends StatelessWidget {
  const ConvertCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert Currency'),
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Convert Currency',
        child: Icon(Icons.shuffle),
      ),
    );
  }
}
