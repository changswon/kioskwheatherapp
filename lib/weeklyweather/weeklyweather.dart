import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final String temp;

  NextPage(this.temp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text(
          'Temperature for 7 days: $temp\u2103',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
