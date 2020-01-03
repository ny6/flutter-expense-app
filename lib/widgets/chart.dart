import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (Transaction tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTxValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxValues
              .map((tx) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      tx['day'],
                      tx['amount'],
                      totalSpent == 0
                          ? 0
                          : (tx['amount'] as double) / totalSpent,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
