import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget{
  
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index){
      
      final weekDay = _getWeekDay(index);  
      
      return {
        'day': _getDayLetter(weekDay),
        'value': _getDailyValue(weekDay), 
      };
    });
  }

  String _getDayLetter(DateTime weekDay){
    return DateFormat.E().format(weekDay)[0];
  }

  DateTime _getWeekDay(int index){
    //Se hoje é segunda e index = 0 -> weekDay = segunda. 
     //se hoje é segunda e index = 1 -> weekDay = domingo. and so on...
    return DateTime.now().subtract(
        Duration(days: index),
      ); 
  }

  double _getDailyValue(DateTime weekDay){
    
      double  totalSum = 0;
     
      for(var t in _recentTransactions){
        int diffDays = t.date.difference(weekDay).inDays;
        if(diffDays == 0) // se é a mesma data
          totalSum += t.value;
      }

      return totalSum;
  }

  @override
  Widget build(BuildContext context) {
      
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map(
          (tr){
            return ChartBar(
              label: tr['day'],
              value: tr['value'],
              percentage: 0,
            );
           
          }
        ).toList(),
      ),
    );
  }
}
