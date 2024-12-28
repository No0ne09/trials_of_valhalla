import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(150, 0, 0, 1)),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.normal, fontFamily: defaultFontFamily),
      ),
    );
  }
}
