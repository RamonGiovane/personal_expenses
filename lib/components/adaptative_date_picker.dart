import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChaged;

  AdaptativeDatePicker(this.selectedDate, this.onDateChaged);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
          height: 180,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateChaged ,
          ),
        )
        : Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        "Data da Transação: ${selectedDate == null ? " - - -" : DateFormat('dd/MM/y').format(selectedDate)}")),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openDatePicker(context),
                )
              ],
            ),
          );
  }

  void _openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      onDateChaged(pickedDate);

    });
  }
}
