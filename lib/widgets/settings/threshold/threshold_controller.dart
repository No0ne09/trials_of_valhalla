import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class ThresholdController extends ConsumerWidget {
  const ThresholdController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threshold = ref.watch(thresholdProvider);
    return Card(
      child: ListTile(
        title: Text(
          "Shake threshold",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontFamily: defaultFontFamily,
              ),
        ),
        trailing: DropdownButton(
          value: threshold,
          items: [
            DropdownMenuItem(
              child: Text("Very low"),
              value: 1.05,
            ),
            DropdownMenuItem(
              child: Text("Low"),
              value: 1.35,
            ),
            DropdownMenuItem(
              child: Text("Medium"),
              value: 1.5,
            ),
            DropdownMenuItem(
              child: Text("High"),
              value: 2.6,
            ),
            DropdownMenuItem(
              child: Text("Very High"),
              value: 3.0,
            ),
          ],
          onChanged: (value) async {
            if (value == null) return;
            await savePrefs("threshold", value);
            ref.read(thresholdProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
