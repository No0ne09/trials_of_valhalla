import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/layout/complex_screen_base.dart';
import 'package:trials_of_valhalla/widgets/settings/custom_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shake = ref.watch(shakeProvider);
    final music = ref.watch(bgMusicProvider);
    final sfx = ref.watch(sfxProvider);
    return ComplexScreenBase(
      divider: 1.8,
      title: settings,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSwitch(
              text: useShake,
              value: shake,
              onChanged: (value) async {
                await savePrefs("shake", value);
                ref.read(shakeProvider.notifier).state = value;
              },
            ),
            CustomSwitch(
              text: playMusic,
              value: music,
              onChanged: (value) async {
                await savePrefs("music", value);
                ref.read(bgMusicProvider.notifier).state = value;
              },
            ),
            CustomSwitch(
              text: playSfx,
              value: sfx,
              onChanged: (value) async {
                await savePrefs("sfx", value);
                ref.read(sfxProvider.notifier).state = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
