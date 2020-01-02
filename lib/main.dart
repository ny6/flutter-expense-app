import 'dart:io';
import 'package:expense/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: kTextTheme,
            button: ThemeData.light()
                .textTheme
                .button
                .copyWith(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: kTitleStyle),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.dark().textTheme.copyWith(
            title: kTextTheme,
            button: ThemeData.light()
                .textTheme
                .button
                .copyWith(color: Colors.black)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(title: kTitleStyle),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  List<Transaction> _userTransactions = [];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      id: title,
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => SafeArea(child: NewTransaction(_addNewTransaction)),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
              style: TextStyle(
                color: isDarkTheme(context) ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    final viewHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = Container(
      height: viewHeight * 0.65,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    Widget getChartWidget(double height) => Container(
          height: viewHeight * height,
          child: Chart(_recentTransactions),
        );

    final showChartWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show Chart',
          style: Theme.of(context).textTheme.title,
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    );

    final pageBody = SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape) getChartWidget(0.3),
            if (!isLandscape) txListWidget,
            if (isLandscape) showChartWidget,
            if (isLandscape) _showChart ? getChartWidget(0.7) : txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
