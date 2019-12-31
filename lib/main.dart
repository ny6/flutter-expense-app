import 'package:flutter/material.dart';
import 'package:expense/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Mac',
      amount: 699,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New iPhone',
      amount: 799,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Text('CHART'),
            elevation: 5,
          ),
          Column(
            children: <Widget>[
              ...transactions.map((tx) => tx.getTransactionCard()).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
