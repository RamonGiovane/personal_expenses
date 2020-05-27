import 'package:flutter/material.dart';

String monetaryVal(double value) {
  return "R\$ " + value.toStringAsFixed(2);
}

Text customText({
  @required String content,
  @required TextStyle style,
}) {
  return Text(content, style: style);
}

Text titleThemeText({
  @required String content,
  @required BuildContext context,
}) {
  return customText(
    content: content,
    style: Theme.of(context).textTheme.title,
  );
}

Text boldText(
    String content,
    {Color color = Colors.black,
    double size = 16}) {
    var style = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: color,
        );
  return Text(content, style: style);
}
