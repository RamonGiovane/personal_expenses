import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.button.color;
    final btnColor = Theme.of(context).primaryColor;

    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: btnColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : FlatButton(
            child: Text(label),
            color: btnColor,
            textColor: textColor,
            onPressed: onPressed,
          );
  }
}
