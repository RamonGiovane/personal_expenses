import 'dart:js';

import 'package:flutter/material.dart';


  
  String monetaryVal(double value) {
    return "R\$ " + value.toStringAsFixed(2);
  }

  Text boldText(
      {@required String content,
      BuildContext context,
      Color color = Colors.black,
      double size = 16}) {
    
    var style = 
      context == null ? 
      Theme.of(context).textTheme.title 
      
      :
      
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
      );
    return Text(
      content,
      style: style
    );
  }
