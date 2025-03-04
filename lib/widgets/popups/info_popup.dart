import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup({
    required this.title,
    required this.desc,
    super.key,
  });

  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: accentColor, foregroundColor: Colors.white),
          child: Text(
            "Ok",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontFamily: defaultFontFamily,
                ),
          ),
        ),
      ],
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontFamily: defaultFontFamily,
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Text(
        desc,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontFamily: defaultFontFamily,
            ),
      ),
    );
  }
}
