import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  final _listIcon = Platform.isIOS ? CupertinoIcons.news : Icons.list;
  final _chartIcon = Platform.isIOS ? CupertinoIcons.news_solid : Icons.insert_chart;
  final _addIcon = Platform.isIOS ? CupertinoIcons.add : Icons.add;
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

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;



    final appBar = _getAppBar();
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Center(
      child: Platform.isIOS
          ? CupertinoPageScaffold(
              child: _getScaffoldBody(isLandscape, availableHeight),
              navigationBar: appBar,
            )
          : Scaffold(
              appBar: appBar,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: _getScaffoldBody(isLandscape, availableHeight),
                ),
              ),
              floatingActionButton: _getNewTransactionFloatingBtn(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
    );
  }

  Widget _getAdaptativeIconButton(
      {@required Icon icon, @required Function onPressed}) {
    return Platform.isIOS
        ? GestureDetector(child: icon, onTap: onPressed)
        : IconButton(icon: icon, onPressed: onPressed);
  }

  PreferredSizeWidget _getAppBar() {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 if(isLandscape) _getChartIcon(),
                _getNewTransactionIcon(),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              if(isLandscape) _getChartIcon(),
              _getNewTransactionIcon(),
            ],
          );
  }

  Widget _getScaffoldBody(bool isLandscape, double availableHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (isLandscape) _getChartSwitch(),
        if (_displayChart || !isLandscape)
          Container(
            height: availableHeight * (isLandscape ? 0.6 : 0.25),
            child: Chart(_recentTransactions),
          ),
        if (!_displayChart || !isLandscape)
          Column(
            children: <Widget>[
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.75),
                child: TransactionList(_transactions, _removeTransaction),
              ),
            ],
          ),
      ],
    );
  }

  Widget _getChartSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Exibir Gráfico"),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
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

  Widget _getNewTransactionIcon() {
    return _getAdaptativeIconButton(
      icon: Icon(_addIcon),
      onPressed: () {
        _openTransactionFormModal(context);
      },
    );
  }

  Widget _getChartIcon() {
    return _getAdaptativeIconButton(
        icon: Icon((_displayChart == true) ? _listIcon : _chartIcon),
        onPressed: () {
          setState(() {
            _displayChart = !_displayChart;
          });
        });
  }

  Widget _getNewTransactionFloatingBtn() {
    return Platform.isIOS
        ? Container()
        : FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _openTransactionFormModal(context);
            },
          );
  }
}
