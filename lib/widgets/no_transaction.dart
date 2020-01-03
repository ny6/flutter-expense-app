import 'package:flutter/material.dart';

class NoTransactionWidget extends StatelessWidget {
  const NoTransactionWidget(this.constraints);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
