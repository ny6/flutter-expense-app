import 'package:flutter/material.dart';
import '../utils/helper.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.amount, this.spendingPctOfTotal);

  final String label;
  final double amount;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) => Column(
        children: <Widget>[
          Container(
            height: constraint.maxHeight * 0.11,
            child: FittedBox(child: Text('\$${amount.toStringAsFixed(2)}')),
          ),
          SizedBox(height: constraint.maxHeight * 0.05),
          Container(
            height: constraint.maxHeight * 0.67,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: getPrimaryColor(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraint.maxHeight * 0.05),
          Container(
            height: constraint.maxHeight * 0.12,
            child: FittedBox(child: Text(label)),
          ),
        ],
      ),
    );
  }
}
