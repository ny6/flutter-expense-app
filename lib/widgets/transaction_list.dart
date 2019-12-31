import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) => transactions[index].getTransactionCard(),
        itemCount: transactions.length,
      ),
    );
  }
}
