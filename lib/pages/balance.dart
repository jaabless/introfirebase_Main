import 'package:flutter/material.dart';

class balance extends StatefulWidget {
  @override
  _balanceState createState() => _balanceState();
}

class _balanceState extends State<balance> {
  List<String> options = [
    'Balance',
    'Check',
    'Hello',
    'Balance',
    'Check',
    'Hello'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance'),
      ),
      body: Center(
          child: Text(
        "You have no remaining balance",
        style: TextStyle(
          fontSize: 18,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Text('Home'),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
      ),
    );
  }
}
