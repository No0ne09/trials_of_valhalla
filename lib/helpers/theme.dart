import 'package:flutter/material.dart';

const defaultFontFamily = 'Jersey10';
const accentColor = Color.fromRGBO(150, 0, 0, 1);
OutlineInputBorder getTextFieldBorder({Color color = Colors.transparent}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color),
  );
}
