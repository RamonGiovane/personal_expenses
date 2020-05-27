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
      
      var i = {
        'day': _getDayLetter(weekDay),
        'value': _getDailyValue(weekDay), 
      };

      print("${DateFormat.E().format(weekDay)} - ${i['value']}");

      return i;
    }).reversed.toList();
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
        
        print(_recentTransactions.length);
        //int diffDays = t.date.weekday == weekDay;
        if(t.date.weekday == weekDay.weekday){ // se é a mesma data
          totalSum += t.value;
        }
      } 

      return totalSum;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr){
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
      
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map(
            (tr){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    
                  label: tr['day'],
                  value: tr['value'],
                  percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
                ),
              );
             
            }
          ).toList(),
        ),
      ),
    );
  }
}
