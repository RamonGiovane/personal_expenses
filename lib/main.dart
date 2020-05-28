import 'dart:math';
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';
import 'package:personal_expenses/components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurple,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _displayChart = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => id == t.id);
    });
  }

  void _addTransaction(String title, double value, DateTime dateTime) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: dateTime,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  AppBar _showAppBar() {
    return AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        _showChartIcon(),
        _showNewTransactionIcon(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = _showAppBar();
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Center(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) _showChartSwitch(),
              if (_displayChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 0.6 : 0.25),
                  child: Chart(_recentTransactions),
                ),
              if (!_displayChart || !isLandscape)
                Column(
                  children: <Widget>[
                    Container(
                      height: availableHeight * 0.75,
                      child: TransactionList(_transactions, _removeTransaction),
                    ),
                  ],
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _openTransactionFormModal(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _showChartSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Exibir Gráfico"),
        Switch(
          value: _displayChart,
          onChanged: (value) {
            setState(() {
              _displayChart = value;
            });
          },
        ),
      ],
    );
  }

  Widget _showNewTransactionIcon() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _openTransactionFormModal(context);
      },
    );
  }

  Widget _showChartIcon() {
    return IconButton(
        icon: Icon( (_displayChart == true) ? Icons.list : Icons.insert_chart),
        onPressed: () {
          setState(() { 
            _displayChart = !_displayChart;
          });
    });
  }
}
