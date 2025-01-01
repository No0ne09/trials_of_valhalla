import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({required this.index, required this.data, super.key});
  final int index;
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      leading: Text(
        textAlign: TextAlign.center,
        "${index + 1}",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontFamily: defaultFontFamily,
              color: accentColor,
            ),
      ),
      trailing: Text(
        "${data["score"].toString()} $points",
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontFamily: defaultFontFamily,
            ),
      ),
      title: Text(
        softWrap: true,
        data["user"],
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontFamily: defaultFontFamily,
            ),
      ),
    );
  }
}
