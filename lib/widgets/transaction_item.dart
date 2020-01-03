import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(this.tx, this.deleteTx);

  final Transaction tx;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('\$${tx.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTx(tx.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(tx.id),
              ),
      ),
    );
  }
}
