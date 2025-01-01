import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class CustomSwitch extends ConsumerWidget {
  const CustomSwitch(
      {required this.text,
      required this.dataKey,
      required this.provider,
      super.key});

  final String text;
  final String dataKey;
  final StateProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(provider);
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
        onChanged: (value) async {
          final audio = ref.read(sfxProvider);
          if (audio) playSFX(buttonSFXPath);
          await savePrefs(dataKey, value);
          ref.read(provider.notifier).state = value;
        },
      ),
    );
  }
}
