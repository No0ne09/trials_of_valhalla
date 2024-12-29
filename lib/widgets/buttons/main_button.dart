import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.text,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String text;
  final void Function() onPressed;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(150, 0, 0, 1),
          foregroundColor: Colors.white),
      onPressed: onPressed,
      icon: icon,
      iconAlignment: IconAlignment.end,
      label: Row(
        children: [
          const Spacer(),
          Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.normal, fontFamily: defaultFontFamily),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
