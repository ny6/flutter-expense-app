import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTx);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                const SizedBox(height: 20),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle:
                    Text(DateFormat.yMMMd().format(transactions[index].date)),
                trailing: MediaQuery.of(context).size.width > 460
                    ? FlatButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        textColor: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
              ),
            ),
            itemCount: transactions.length,
          );
  }
}
