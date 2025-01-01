import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/screens/complex_screen_base.dart';
import 'package:trials_of_valhalla/widgets/settings/custom_switch.dart';
import 'package:trials_of_valhalla/widgets/settings/threshold/shake_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComplexScreenBase(
      divider: 1.5,
      title: settings,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const ShakeSettings(),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
