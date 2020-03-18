import 'package:flutter/material.dart';


  
  String monetaryVal(double value) {
    return "R\$ " + value.toStringAsFixed(2);
  }

  Text boldText(
      {@required String content,
      Color color = Colors.black,
      double size = 16}) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
      ),
    );
  }

}