import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectStyle {
  static TextStyle projectTheme = const TextStyle(
      fontSize: 16,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      letterSpacing: 2);
}

InputDecoration buildInputDecoration({
  required String labelText,
  String? hintText,
  IconData? icon,
  String? errortext,
}) {
  return InputDecoration(
    border: OutlineInputBorder(),
    labelText: labelText,
    hintText: hintText ?? '',
    errorText: errortext,
  );
}

InputDecoration buildCvvDecoration({
  required String labelText,
  String? hintText,
  IconData? icon,
  String? errortext,
}) {
  return InputDecoration(
    border: OutlineInputBorder(),
    labelText: labelText,
    hintText: hintText ?? '',
    prefixIcon: Icon(icon),
    errorText: errortext,
  );
}

class ProjectPadding {
  static const pagePaddingFull = EdgeInsets.all(16);
  static const pagePaddingTop = EdgeInsets.only(top: 20);
  static const pagePaddingOnly = EdgeInsets.only(right: 10, left: 10);
  static const pageOnlyRow =EdgeInsets.only(right: 20, left: 10);
  static const pagePaddingLeft = EdgeInsets.only(left: 10);
  static const pagePaddingRight = EdgeInsets.only(right: 15);
  static const pagePaddingTopBottom = EdgeInsets.only(bottom: 20);
}

class ProjectDecorationBox {
  static BoxDecoration projectDecoration = BoxDecoration(
    color: Colors.grey[950],
    border: Border.all(color: const Color.fromARGB(153, 221, 107, 107)),
  );
}
