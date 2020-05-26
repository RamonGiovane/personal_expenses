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
          elevation: 5,
          // margin: EdgeInsets.symmetric(
          //   vertical: 8,
          //   horizontal: 5,
          // ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text(
                    "R\$${tr.value}"
                  ),
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat("d MMM y").format(tr.date),
            ),
          ),
        );
      },
    );
  }
}
