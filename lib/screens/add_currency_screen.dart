import 'package:flutter/material.dart';

class AddCurrency extends StatelessWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Currency',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [Text('')],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Save Currency',
        child: Icon(Icons.check),
      ),
    );
  }
}
