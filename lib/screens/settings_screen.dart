import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/layout/complex_screen_base.dart';
import 'package:trials_of_valhalla/widgets/settings/custom_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ComplexScreenBase(
      divider: 1.8,
      title: settings,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSwitch(
              text: useShake,
              provider: shakeProvider,
              dataKey: "shake",
            ),
            CustomSwitch(
              text: playMusic,
              provider: bgMusicProvider,
              dataKey: "music",
            ),
            CustomSwitch(
              text: playSfx,
              provider: sfxProvider,
              dataKey: "sfx",
            ),
          ],
        ),
      ),
    );
  }
}
