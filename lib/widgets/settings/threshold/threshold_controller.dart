import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class ThresholdController extends ConsumerWidget {
  const ThresholdController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threshold = ref.watch(thresholdProvider);
    return Card(
      child: ListTile(
        title: Text(
          shakeThreshold,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontFamily: defaultFontFamily,
              ),
        ),
        trailing: DropdownButton(
          value: threshold,
          items: [
            ...thresholdsOptions.map((item) {
              final key = item.keys.first;
              return DropdownMenuItem(
                value: item[key],
                child: Text(
                  key,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontFamily: defaultFontFamily,
                      ),
                ),
              );
            })
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
