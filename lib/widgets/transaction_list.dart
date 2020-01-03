import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';
import './no_transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTx);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => NoTransactionWidget(constraints),
          )
        : ListView.builder(
            itemBuilder: (ctx, i) => TransactionItem(transactions[i], deleteTx),
            itemCount: transactions.length,
          );
  }
}
