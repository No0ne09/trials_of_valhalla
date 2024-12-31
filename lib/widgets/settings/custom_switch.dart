import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class CustomSwitch extends ConsumerWidget {
  const CustomSwitch(
      {required this.text,
      required this.value,
      required this.onChanged,
      super.key});

  final String text;
  final bool value;
  final void Function(bool newValue) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SwitchListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontFamily: defaultFontFamily,
              ),
        ),
        value: value,
        activeColor: accentColor,
        inactiveTrackColor: Colors.white,
        inactiveThumbColor: Colors.black,
        onChanged: (value) {
          final audio = ref.read(sfxProvider);
          if (audio) {
            playSFX(buttonSFXPath);
          }
          onChanged(value);
        },
      ),
    );
  }
}
