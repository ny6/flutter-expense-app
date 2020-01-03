import 'dart:io';
import 'package:expense/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.onSubmit);

  final Function onSubmit;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final title = _titleController.text;
    final amount = _amountController.text;

    if (title.isEmpty || amount.isEmpty || _selectedDate == null) return;
    if (double.parse(amount) <= 0) return;

    widget.onSubmit(title, double.parse(amount), _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Choosen!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: const Text('Choose Date'),
                            onPressed: _presentDatePicker,
                          )
                        : FlatButton(
                            textColor: getPrimaryColor(context),
                            child: const Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: getPrimaryColor(context),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
