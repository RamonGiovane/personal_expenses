import 'package:flutter/material.dart';
import 'package:personal_expenses/utils/utils.dart' as utils;
import '../models/transaction.dart';
import "package:intl/intl.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child:
          _transactions.isEmpty ? _showIdleImage(context) : _showTransactions(context),
    );
  }

  Widget _showIdleImage(BuildContext context) {
    return Column(
      children: <Widget>[
        
        SizedBox(height: 20), //isto serve para dar um espaço entre os componentes

        utils.titleThemeText(content: 'Nenhuma transação registrada ainda!', context: context),
        
        SizedBox(height: 20),

        Container(
          height: 200 ,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );

  }

  Widget _showTransactions(BuildContext context) {
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (ctx, index) {
        final tr = _transactions[index];
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor, //Colors.purple,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: utils.boldText(
                    content: utils.monetaryVal(tr.value),
                    size: 20,
                    color: Theme.of(context).primaryColor),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  utils.titleThemeText(content: tr.title, context: context),
                  utils.boldText(
                      content: DateFormat('d MMM y').format(tr.date),
                      color: Colors.grey[600]),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
