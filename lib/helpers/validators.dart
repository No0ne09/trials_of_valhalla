import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

final emailValidator = ValidationBuilder(localeName: 'en').email().build();
final basicValidator = ValidationBuilder(localeName: 'en')
    .add(
      (value) => value.toString().trim().isEmpty
          ? "This field must not contain spaces alone."
          : null,
    )
    .build();
String? Function(String?) createPasswordValidator(
    TextEditingController passwordController) {
  return ValidationBuilder(localeName: 'en')
      .minLength(8)
      .add((value) {
        return value == passwordController.text
            ? null
            : 'Passwords must be the same.';
      })
      .add(
        (value) => value.toString().contains((' '))
            ? "The password must not contain spaces."
            : null,
      )
      .build();
}
