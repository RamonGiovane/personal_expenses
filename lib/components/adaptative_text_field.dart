import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function onSubmit;
  final bool _isNumeric;


  AdaptativeTextField(this.label, this.controller, this.onSubmit) :
    _isNumeric = false;
  

  AdaptativeTextField.numeric(this.label, this.controller, this.onSubmit) :
    _isNumeric = true;
  

  @override
  Widget build(BuildContext context) {
    return !Platform.isIOS
        ? Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmit,
              placeholder: label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
              keyboardType: _isNumeric ? TextInputType.numberWithOptions(decimal: true) : null,

              
            ),
        )
        : TextField(
            onSubmitted: onSubmit,
            controller: controller,
            keyboardType: _isNumeric ? TextInputType.numberWithOptions(decimal: true) : null,
            decoration: InputDecoration(labelText: label),
    );
  }
}
