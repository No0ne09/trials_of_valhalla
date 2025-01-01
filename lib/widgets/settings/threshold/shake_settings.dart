import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/settings/custom_switch.dart';
import 'package:trials_of_valhalla/widgets/settings/threshold/threshold_controller.dart';

class ShakeSettings extends ConsumerWidget {
  const ShakeSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showController = ref.watch(shakeProvider);
    return Column(
      children: [
        CustomSwitch(
          text: useShake,
          provider: shakeProvider,
          dataKey: "shake",
        ),
        if (showController) const ThresholdController(),
      ],
    );
  }
}
