import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/adaptative_button.dart';
import 'package:personal_expenses/components/adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
               AdaptativeTextField(
                'Título',
                titleController,
                (_) => _submitForm()
              ),
              AdaptativeTextField.numeric(
                'Valor (R\$)',
                valueController,
                (_) => _submitForm(),
              ),
              // TextField(
              //   controller: valueController,
              //   onSubmitted: (_) {
              //     _submitForm();
              //   },
              //   keyboardType: TextInputType.numberWithOptions(decimal: true),
              //   decoration: InputDecoration(labelText: 'Valor (R\$)'),
              // ),
              _showDateForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    "Nova Transação",
                    _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDateForm() {
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                  "Data da Transação: ${_selectedDate == null ? " - - -" : DateFormat('dd/MM/y').format(_selectedDate)}")),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Selecionar Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _openDatePicker,
          )
        ],
      ),
    );
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() => _selectedDate = pickedDate);
    });
  }
}
